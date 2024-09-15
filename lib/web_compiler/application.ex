defmodule WebCompiler.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      WebCompilerWeb.Telemetry,
      {DNSCluster, query: Application.get_env(:web_compiler, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: WebCompiler.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: WebCompiler.Finch},
      # Start a worker by calling: WebCompiler.Worker.start_link(arg)
      # {WebCompiler.Worker, arg},
      # Start to serve requests, typically the last entry
      WebCompilerWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: WebCompiler.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    WebCompilerWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
