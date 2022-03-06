defmodule Gituser.User.Commands.ListUserDataTest do
  use Gituser.DataCase, async: true

  alias Gituser.User.Commands.ListUserData
  alias Gituser.Clients.GithubMock

  describe "execute/1" do
    test "succeeds if user exists" do
      expect(GithubMock, :user_repos, fn _user ->
        {:ok, build_list(2, :user_repo)}
      end)

      assert [
               %{description: _, html_url: _, id: _, name: _, stargazers_count: _},
               %{description: _, html_url: _, id: _, name: _, stargazers_count: _}
             ] = ListUserData.execute("a_user")
    end

    test "fails if user not exists" do
      expect(GithubMock, :user_repos, fn _user ->
        {:error, :not_found}
      end)

      assert {:error, :not_found} = ListUserData.execute("a_user")
    end
  end
end
