defmodule GituserWeb.GithubUserControllerTest do
  use GituserWeb.ConnCase, async: true

  alias Gituser.Clients.GithubMock
  alias GituserWeb.Auth.Guardian

  setup %{conn: conn} do
    user = insert(:user)
    {:ok, token, _claims} = Guardian.encode_and_sign(user)
    conn = put_req_header(conn, "authorization", "Bearer #{token}")
    {:ok, conn: conn, user: user}
  end

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

  describe "/api/user" do
    test "succeeds if user is created", %{conn: conn} do
      assert %{
               "message" => "User created!",
               "user" => %{"id" => _, "password" => _}
             } =
               conn
               |> post("/api/user", %{"password" => "123456"})
               |> json_response(201)
    end

    test "fails if password is not valid", %{conn: conn} do
      assert %{"message" => %{"password" => ["should be at least 6 character(s)"]}} =
               conn
               |> post("/api/user", %{"password" => "12345"})
               |> json_response(400)
    end
  end

  describe "/api/user/login" do
    test "fails if password is not valid", %{conn: conn, user: user} do
      assert %{"message" => %{"password" => ["should be at least 6 character(s)"]}} =
               conn
               |> post("/api/user", %{"password" => "12345", "id" => user.id})
               |> json_response(400)
    end

    test "fails if is not authenticated", %{conn: conn} do
      assert %{"message" => %{"password" => ["should be at least 6 character(s)"]}} =
               conn
               |> post("/api/user", %{"password" => "12345", "id" => Ecto.UUID.generate()})
               |> json_response(400)
    end
  end
end
