defmodule Gituser.Clients.GithubTest do
  use Gituser.DataCase, async: true

  alias Gituser.Clients.Github
  alias Plug.Conn

  describe "user_repos/2" do
    setup do
      bypass = Bypass.open()
      url = endpoint_url(bypass.port)

      {:ok, bypass: bypass, url: url}
    end

    test "succeeds if user exists", %{bypass: bypass, url: url} do
      user = "vinolivae"

      body = ~s({
        "id": 341370284,
        "name": "Android",
        "html_url": "https://github.com/vinolivae/Android",
        "description": "Um repositório onde coloco pequenos projetos ",
        "stargazers_count": 0
      })

      Bypass.expect(bypass, "GET", "users/#{user}/repos", fn conn ->
        conn
        |> Conn.put_resp_header("content-Type", "application/json")
        |> Conn.resp(200, body)
      end)

      assert {:ok,
              %{
                "description" => "Um repositório onde coloco pequenos projetos ",
                "html_url" => "https://github.com/vinolivae/Android",
                "id" => 341_370_284,
                "name" => "Android",
                "stargazers_count" => 0
              }} = Github.user_repos(url, user)
    end

    test "fails if user not exists", %{bypass: bypass, url: url} do
      user = "not_exists"

      Bypass.expect(bypass, "GET", "users/#{user}/repos", fn conn ->
        Conn.resp(conn, 404, "")
      end)

      assert {:error, :not_found} = Github.user_repos(url, user)
    end
  end

  defp endpoint_url(port), do: "http://localhost:#{port}/"
end
