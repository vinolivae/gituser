defmodule Gituser.Repo do
  use Ecto.Repo,
    otp_app: :gituser,
    adapter: Ecto.Adapters.Postgres
end
