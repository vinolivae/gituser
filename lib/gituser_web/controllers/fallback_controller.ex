defmodule GituserWeb.FallbackController do
  use GituserWeb, :controller

  alias GituserWeb.ErrorView

  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(404)
    |> put_view(ErrorView)
    |> render("error.json", result: "not_found")
  end

  def call(conn, {:error, :bad_request}) do
    conn
    |> put_status(404)
    |> put_view(ErrorView)
    |> render("error.json", result: "bad_request")
  end

  def call(conn, {:error, %Ecto.Changeset{}} = changeset) do
    conn
    |> put_status(:bad_request)
    |> put_view(ErrorView)
    |> render("error.json", result: changeset)
  end
end
