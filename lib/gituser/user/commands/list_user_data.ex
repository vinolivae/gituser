defmodule Gituser.User.Commands.ListUserData do
  def execute(user_name) do
    case github_client().user_repos(user_name) do
      {:ok, user_datas} ->
        datas = Enum.map(user_datas, &build_user_data/1)
        {:ok, datas}

      error ->
        error
    end
  end

  defp build_user_data(user_data) do
    %{
      id: user_data["id"],
      name: user_data["name"],
      description: user_data["description"],
      html_url: user_data["html_url"],
      stargazers_count: user_data["stargazers_count"]
    }
  end

  defp github_client, do: Application.fetch_env!(:gituser, __MODULE__)[:github_adapter]
end
