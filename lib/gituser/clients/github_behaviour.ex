defmodule Gituser.Clients.GithubBehaviour do
  @callback user_repos(String.t()) :: {:ok, map()} | {:error, :not_found}
end
