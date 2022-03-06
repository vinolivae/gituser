defmodule GituserWeb.Router do
  use GituserWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", GituserWeb do
    pipe_through :api

    post "/user", GithubUserController, :create
    get "/user/:user_name", GithubUserController, :show_all
  end

  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
