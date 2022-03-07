defmodule Gituser.User.Commands.GetUser do
  alias Gituser.Schemas.User
  alias Gituser.Repo

  def by_id(id) when is_binary(id) do
    case Repo.get(User, id) do
      nil -> {:error, :not_found}
      user -> {:ok, user}
    end
  end
end
