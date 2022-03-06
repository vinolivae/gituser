defmodule Gituser.Clients.Github do
  use Tesla

  alias Gituser.Clients.GithubBehaviour
  alias Tesla.Env

  plug Tesla.Middleware.Headers, [{"user-agent", "vinolivae"}]
  plug Tesla.Middleware.JSON

  @behaviour GithubBehaviour

  @base_url "https://api.github.com"

  @doc """
  Return a list with all user repos.

  iex > alias Gituser.Clients.Github
  iex > Github.user_repos("valid_user")
  """
  @spec user_repos(url :: String.t(), user_name :: String.t()) ::
          {:ok, map()} | {:error, :not_found}
  def user_repos(url \\ @base_url, user_name) do
    "#{url}/users/#{user_name}/repos"
    |> get()
    |> handle_response()
  end

  defp handle_response({:ok, %Env{status: 404, body: _body}}), do: {:error, :not_found}
  defp handle_response({:ok, %Env{status: 200, body: body}}), do: {:ok, body}
end
