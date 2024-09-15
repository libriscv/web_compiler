defmodule WebCompiler.Repo do
  use Ecto.Repo,
    otp_app: :web_compiler,
    adapter: Ecto.Adapters.SQLite3
end
