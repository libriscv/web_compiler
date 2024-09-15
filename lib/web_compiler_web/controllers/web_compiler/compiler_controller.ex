defmodule WebCompilerWeb.CompileController do
  use WebCompilerWeb, :controller

  @doc """
  Handles the POST request to compile source files into .elf format.
  """
  def create(conn, _params) do
    conn
    |> put_status(:internal_server_error)
    |> json(%{error: "Internal server error"})
  end
end
