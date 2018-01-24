defmodule YndPhxBootstrapWeb.HealthChecks do
  @moduledoc """
  YndPhxBootstrapWeb.HealthChecks is responsible for checking of the health of the app.
  """
  alias Ecto.Adapters.SQL
  alias YndPhxBootstrap.Repo

  def check_ynd_phx_bootstrap_repo do
    %{num_rows: 1, rows: [[1]]} = SQL.query!(Repo, "SELECT 1")
    :ok
  end
end
