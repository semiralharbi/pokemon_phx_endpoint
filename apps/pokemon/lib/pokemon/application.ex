defmodule Pokemon.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      Pokemon.Repo,
      {DNSCluster, query: Application.get_env(:pokemon, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Pokemon.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Pokemon.Finch}
      # Start a worker by calling: Pokemon.Worker.start_link(arg)
      # {Pokemon.Worker, arg}
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: Pokemon.Supervisor)
  end
end
