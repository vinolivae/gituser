defmodule GituserWeb.GithubUserControllerTest do
  use GituserWeb.ConnCase, async: true

  alias Gituser.Clients.GithubMock

  describe "/api/user/:user_name" do
    test "succeeds if return a list with repo data", %{conn: conn} do
      expect(GithubMock, :user_repos, fn _user ->
        {:ok, build_list(1, :user_repo)}
      end)

      assert %{
               "data" => [
                 %{
                   "description" => _,
                   "html_url" => _,
                   "id" => _,
                   "name" => _,
                   "stargazers_count" => _
                 }
               ]
             } =
               conn
               |> get("/api/user/user_name")
               |> json_response(200)
    end

    test "fails if user not exists", %{conn: conn} do
      expect(GithubMock, :user_repos, fn _user ->
        {:error, :not_found}
      end)

      assert %{"error" => "not_found"} =
               conn
               |> get("/api/user/user_name")
               |> json_response(404)
    end
  end
end
