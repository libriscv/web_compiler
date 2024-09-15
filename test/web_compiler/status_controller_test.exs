defmodule WebCompilerWeb.StatusControllerTest do
  use WebCompilerWeb.ConnCase
  use Phoenix.Router

  describe "GET /status/:queueId" do
    test "returns 404 Not Found regardless of queue ID existence", %{conn: conn} do
      # Test with a placeholder queue ID
      conn = get(conn, "/status/placeholder_queue_id")
      assert json_response(conn, 404) == %{"error" => "Queue ID not found"}

      # Test with a non-existing queue ID
      conn = get(conn, "/status/non_existing_queue_id")
      assert json_response(conn, 404) == %{"error" => "Queue ID not found"}
    end
  end
end
