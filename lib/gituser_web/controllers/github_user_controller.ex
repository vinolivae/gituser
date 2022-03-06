defmodule GituserWeb.GithubUserController do
  use GituserWeb, :controller

  alias Gituser
  alias GituserWeb.FallbackController

  action_fallback FallbackController

  def show_all(conn, %{"user_name" => name}) do
    case Gituser.list_users(name) do
      {:ok, datas} -> conn |> put_status(:ok) |> render("show_all.json", datas: datas)
      error -> error
    end
  end
end
