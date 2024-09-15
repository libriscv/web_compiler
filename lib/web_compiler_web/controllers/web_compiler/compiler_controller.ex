defmodule WebCompilerWeb.CompileController do
  use WebCompilerWeb, :controller

  @doc """
  Handles the POST request to compile source files.
  """
  def create(conn, %{"source_code" => source_code}) do
    case Oban.insert(%Oban.Job{
      queue: "compiler_queue",
      worker: MyApp.CompilerWorker,
      args: %{"source_code" => source_code}
    }) do
      {:ok, _job} ->
        conn
        |> put_status(:accepted)
        |> json(%{message: "Compilation has been queued"})

      {:error, reason} ->
        conn
        |> put_status(:internal_server_error)
        |> json(%{error: "Failed to queue the compilation", reason: inspect(reason)})
    end
  end
end
