defmodule Gituser.User.Commands.CreateUser do
  alias Gituser.Schemas.User
  alias Gituser.Repo

  @spec execute(params :: map()) :: {:ok, User.t()} | {:error, Ecto.Changeset.t()}
  def execute(params) do
    case create_user(params) do
      {:ok, _user} = user -> user
      error -> error
    end
  end

  defp create_user(params) do
    params
    |> User.changeset()
    |> Repo.insert()
  end
end
