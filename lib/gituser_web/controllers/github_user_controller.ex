defmodule GituserWeb.GithubUserController do
  use GituserWeb, :controller

  alias Gituser
  alias GituserWeb.FallbackController

  alias Gituser.User.Inputs.CreateUser
  alias Gituser.ChangesetValidation

  action_fallback FallbackController

  def create(conn, params) do
    with {:ok, input} <- ChangesetValidation.cast_and_apply(CreateUser, params),
         {:ok, user} <- Gituser.create_user(input) do
      conn
      |> put_status(:created)
      |> render("created.json", user: user)
    end
  end

  def show_all(conn, %{"user_name" => name}) do
    case Gituser.list_users(name) do
      {:ok, datas} -> conn |> put_status(:ok) |> render("show_all.json", datas: datas)
      error -> error
    end
  end
end
