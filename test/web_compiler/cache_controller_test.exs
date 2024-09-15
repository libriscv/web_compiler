defmodule WebCompilerWeb.CacheControllerTest do
  use WebCompilerWeb.ConnCase

  describe "GET /cache/:key" do
    test "returns 404 Not Found when cache key does not exist", %{conn: conn} do
      non_existing_key = "non_existing_key"
      conn = get(conn, "/cache/#{non_existing_key}")
      assert json_response(conn, 404) == %{
        "error" => "Cache miss, no compiled output found"
      }
    end
  end
end
