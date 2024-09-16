#!/bin/bash

CHROOT_DIR="/chroot"

cp -r /workspace/priv/godot-sandbox/program/cpp/api $CHROOT_DIR/api

cp /workspace/priv/nsjail/main.cpp $CHROOT_DIR/main.cpp

verbose=false
current_version=6
CPPFLAGS="-g -O2 -std=gnu++23 -DVERSION=$current_version -fno-stack-protector -fno-threadsafe-statics"
API="/api"
output="output.elf"
MEMOPS="-Wl,--wrap=memcpy,--wrap=memset,--wrap=memcmp,--wrap=memmove"
STROPS="-Wl,--wrap=strlen,--wrap=strcmp,--wrap=strncmp"
HEAPOPS="-Wl,--wrap=malloc,--wrap=calloc,--wrap=realloc,--wrap=free"
LINKEROPS="$MEMOPS $STROPS $HEAPOPS"
COMPILER="riscv64-linux-gnu-g++-14"
LINKEROPS="$LINKEROPS -fuse-ld=mold"

for file in *.cpp $CHROOT_DIR/api/*.cpp; do
    if [ "$verbose" = true ]; then
        echo "Compiling $file"
    fi
    chroot $CHROOT_DIR $COMPILER $CPPFLAGS -I$API -c $file -o $file.o &
done

wait

chroot $CHROOT_DIR $COMPILER -static $CPPFLAGS $LINKEROPS *.o $API/*.cpp.o -o $output

echo "Compilation completed in chroot environment."
