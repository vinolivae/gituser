defmodule GituserWeb.FallbackController do
  use GituserWeb, :controller

  alias GituserWeb.ErrorView

  def call(conn, {:error, result}) do
    conn
    |> put_status(404)
    |> put_view(ErrorView)
    |> render("error.json", result: result)
  end
end
