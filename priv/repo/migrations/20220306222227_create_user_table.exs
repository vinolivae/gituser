defmodule Gituser.Repo.Migrations.CreateUserTable do
  use Ecto.Migration

  def change do
    create table(:users, primary_key: false) do
      add :id, :uuid, primaru_key: true
      add :password_hash, :string

      timestamps()
    end
  end
end
