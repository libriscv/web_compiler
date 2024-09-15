defmodule WebCompilerWeb.CompilerControllerTest do
  use WebCompilerWeb.ConnCase

  describe "POST /compile" do
    test "returns 500 internal server error when invalid code is submitted", %{conn: conn} do
      body = %{"code" => "invalid code snippet"}
      conn = post(conn, "/compile", body)
      assert json_response(conn, 500) == %{
        "error" => "Internal server error",
      }
    end
  end
end
