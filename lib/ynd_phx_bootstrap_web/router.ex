defmodule YndPhxBootstrapWeb.Router do
  use YndPhxBootstrapWeb, :router

  alias PlugCheckup.Options

  checks = [
    %PlugCheckup.Check{name: "DB", module: YndPhxBootstrapWeb.HealthChecks, function: :check_ynd_phx_bootstrap_repo},
  ]

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/health" do
    forward "/", PlugCheckup, Options.new(checks: checks)
  end

  scope "/api", YndPhxBootstrapWeb do
    pipe_through :api
    get "/echo", DummyController, :echo
    get "/failure", DummyController, :failure
  end
end
