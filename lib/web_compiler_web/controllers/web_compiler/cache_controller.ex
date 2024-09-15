defmodule WebCompilerWeb.CacheController do
  use WebCompilerWeb, :controller

  @doc """
  Handles the GET request to check the cache for a compiled output by hash.
  """
  def show(conn, %{"hash" => hash}) do
    case check_cache(hash) do
      {:ok, file_path} ->
        conn
        |> put_status(:ok)
        |> json(%{
          message: "Cache hit",
          output: file_path
        })
      :error ->
        conn
        |> put_status(:not_found)
        |> json(%{error: "Cache miss, no compiled output found"})
    end
  end

  # Always return :error to simulate a cache miss
  defp check_cache(_hash) do
    :error
  end
end
