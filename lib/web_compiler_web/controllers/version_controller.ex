defmodule WebCompilerWeb.VersionController do
  use WebCompilerWeb, :controller

  def index(conn, _params) do
    {gcc_version_output, 0} = System.cmd("gcc", ["--version"])
    gcc_version = parse_gcc_version(gcc_version_output)

    {rust_version_output, 0} = System.cmd("rustc", ["--version"])
    rust_version = parse_rust_version(rust_version_output)

    version_info = %{
      apiVersion: "1.0.0",
      gccVersion: gcc_version,
      rustVersion: rust_version
    }

    json(conn, version_info)
  end

  defp parse_gcc_version(output) do
    # Extract and trim the version number from the first line of the output
    [first_line | _] = String.split(output, "\n")
    version = Regex.replace(~r/^gcc \(.*\) (\d+\.\d+\.\d+).*$/, first_line, "\\1")
    String.trim(version)
  end

  defp parse_rust_version(output) do
    # Extract and trim the version number from the output
    version = Regex.replace(~r/^rustc (\d+\.\d+\.\d+).*$/, output, "\\1")
    String.trim(version)
  end
end
