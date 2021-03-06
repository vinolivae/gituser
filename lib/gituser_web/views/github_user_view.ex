defmodule GituserWeb.GithubUserView do
  use GituserWeb, :view

  def render("created.json", %{user: user}) do
    %{
      message: "User created!",
      user: %{
        id: user.id,
        password: user.password_hash
      }
    }
  end

  def render("signin.json", %{token: token}) do
    %{
      message: "User signined!",
      token: token
    }
  end

  def render("show_all.json", %{datas: datas}) do
    %{
      data: render_many(datas, __MODULE__, "show.json", as: :data)
    }
  end

  def render("show.json", %{data: data}) do
    %{
      id: data.id,
      name: data.name,
      description: data.description,
      html_url: data.html_url,
      stargazers_count: data.stargazers_count
    }
  end
end
