defmodule WebCompilerWeb.VersionController do
  use WebCompilerWeb, :controller

  def index(conn, _params) do
    {gcc_version_output, 0} = System.cmd("gcc", ["--version"])
    gcc_version = parse_gcc_version(gcc_version_output)

    version_info = %{
      apiVersion: "1.0.0",
      gccVersion: gcc_version
    }

    json(conn, version_info)
  end

  defp parse_gcc_version(output) do
    # Extract the version number from the first line of the output
    [first_line | _] = String.split(output, "\n")
    Regex.replace(~r/^gcc \(.*\) (\d+\.\d+\.\d+).*$/, first_line, "\\1")
  end
end
