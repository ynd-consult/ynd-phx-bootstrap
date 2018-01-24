defmodule YndPhxBootstrapWeb.DummyView do
  use YndPhxBootstrapWeb, :view

  def render("echo.json", conn) do
    conn
    |> Map.take([:query_params, :request_path])
  end
end
