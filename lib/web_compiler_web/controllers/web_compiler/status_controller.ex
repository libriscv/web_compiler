defmodule WebCompilerWeb.StatusController do
  use WebCompilerWeb, :controller

  @doc """
  Handles the GET request to check the status of a queued compilation request by queueId.
  This version is modified to report all statuses as 'not found'.
  """
  def show(conn, _params) do
    conn
    |> put_status(:not_found)
    |> json(%{error: "Queue ID not found"})
  end
end
