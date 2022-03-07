defmodule GituserWeb.Auth.Pipeline do
  use Guardian.Plug.Pipeline, otp_app: :gituser

  plug Guardian.Plug.VerifyHeader
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end
