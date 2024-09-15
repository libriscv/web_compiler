defmodule WebCompilerWeb.VersionControllerTest do
  use WebCompilerWeb.ConnCase, async: true

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

  test "returns Rust version 1.83 or higher", %{conn: conn} do
    conn = get(conn, "/version")
    assert json_response(conn, 200)
    version_data = json_response(conn, 200)
    rust_version = version_data["rustVersion"]

    version_struct = rust_version
    |> Version.parse!()

    major_version = version_struct.major
    minor_version = version_struct.minor

    assert major_version >= 1 and minor_version >= 83
  end
end
