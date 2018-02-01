defmodule YndPhxBootstrapWeb.DummyView do
  use YndPhxBootstrapWeb, :view

  @spec render(binary, map) :: map
  def render("echo.json", echo_data) do
    echo_data
  end
end
