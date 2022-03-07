defmodule Gituser.Clients.GithubBehaviour do
  @doc """
  Callback to define a contract between environments.
  """
  @callback user_repos(String.t()) :: {:ok, map()} | {:error, :not_found}
end
