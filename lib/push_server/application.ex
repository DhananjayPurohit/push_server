defmodule PushServer.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Starts a worker by calling: PushServer.Worker.start_link(arg)
      # {PushServer.Worker, arg}
      Plug.Adapters.Cowboy.child_spec(
        scheme: :http,
        plug: PushServer.Router,
        options: [port: 9000]
      )
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: PushServer.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
