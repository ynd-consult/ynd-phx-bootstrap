defmodule YndPhxBootstrapWeb.DummyController do
  use YndPhxBootstrapWeb, :controller
  require Logger

  alias Plug.Conn

  @spec echo(Conn.t, map) :: Conn.t
  def echo(conn, _params) do
    echo_data = conn
    |> Map.take([:query_params, :request_path])

    render conn, "echo.json", echo_data
  end

  @spec failure(Conn.t, map) :: no_return
  def failure(_conn, _params) do
    _ = Logger.error fn -> "Requsted an endpoint which always fails" end
    raise "This endpoint always fails"
  end
end
