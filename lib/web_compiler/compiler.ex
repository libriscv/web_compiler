defmodule WebCompiler.CompilerWorker do
  use Oban.Worker, queue: :compiler_queue

  @impl Oban.Worker
  def perform(%Oban.Job{args: %{"source_code" => source_code}}) do
    case Compiler.compile(source_code) do
      {:ok, binary} ->
        IO.puts("Compilation successful")
        # Here you might want to save the binary, send it somewhere, etc.
        :ok

      {:error, reason} ->
        IO.puts("Compilation failed: #{inspect(reason)}")
        :error
    end
  end
end
