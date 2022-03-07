defmodule Gituser.Factory do
  use ExMachina.Ecto, repo: Gituser.Repo
  alias Gituser.Schemas.User

  def user_repo_factory do
    %{
      description: "Um repositório onde coloco pequenos projetos ",
      html_url: "https://github.com/example/example",
      id: 1,
      name: "example",
      stargazers_count: 0
    }
  end

  def user_factory do
    %User{password: "123456"}
  end
end
