defmodule WebCompilerWeb.VersionControllerTest do
  use WebCompilerWeb.ConnCase, async: true

  alias WebCompilerWeb.VersionController

  describe "GET /version" do
    test "returns GCC version 13 or higher", %{conn: conn} do
      conn = get(conn, "/version")
      assert json_response(conn, 200)
      version_data = json_response(conn, 200)
      gcc_version = version_data["gccVersion"]

      {major_version, _} = Integer.parse(gcc_version)
      assert major_version >= 13
    end
  end
end
