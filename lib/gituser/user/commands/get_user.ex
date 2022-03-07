defmodule Gituser.User.Commands.GetUser do
  alias Gituser.Schemas.User
  alias Gituser.Repo

  @spec by_id(id :: String.t()) :: {:ok, User.t()} | {:error, :not_found}
  def by_id(id) when is_binary(id) do
    case Repo.get(User, id) do
      nil -> {:error, :not_found}
      user -> {:ok, user}
    end
  end
end
