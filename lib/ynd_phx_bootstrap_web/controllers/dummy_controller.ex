defmodule YndPhxBootstrapWeb.DummyController do
  use YndPhxBootstrapWeb, :controller
  require Logger

  def echo(conn, _params) do
    render conn, "echo.json", conn
  end

  def failure(_conn, _params) do
    Logger.error fn -> "Requsted an endpoint which always fails" end
    raise "This endpoint always fails"
  end
end
