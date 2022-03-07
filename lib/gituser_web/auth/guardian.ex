defmodule GituserWeb.Auth.Guardian do
  @moduledoc """
  Use this module to create authentication tokens.

  To use the guardian it is necessary a previous setup, long but simple.
  And it starts here. We need a subject_for_token and resource_from_claims,
  the rest was added separately.

  The main objective here is to be able, based on the user id, to create token and claims
  so that the JWT can be valid.

  The next step is to create a pipeline to use ready-made plugs in our favor.
  That way we can guarantee specific things. All this is in the "pipeline" module.

  And last but not least, we have to create an error handler, which is the simplest part.
  Just take a look at the module too.

  PS: One of the most important steps is to add the environment settings.
  repo: https://github.com/ueberauth/guardian
  """
  use Guardian, otp_app: :gituser

  alias Gituser.Schemas.User
  alias Gituser.User.Commands.GetUser

  def subject_for_token(%User{id: id}, _claims), do: {:ok, id}

  def resource_from_claims(claims) do
    claims
    |> Map.get("sub")
    |> GetUser.by_id()
  end

  @doc """
  Generate token for the given user.
  """
  def authenticate(%{id: user_id, password: password}) do
    with {:ok, %User{password_hash: hash} = user} <- GetUser.by_id(user_id),
         {:valid_pass?, true} <- {:valid_pass?, Pbkdf2.verify_pass(password, hash)},
         {:ok, token, _claims} <- encode_and_sign(user, %{}, ttl: {1, :minute}) do
      {:ok, token}
    else
      {:valid_pass?, false} -> {:error, :unauthorized}
      error -> error
    end
  end

  def authenticate(_), do: {:error, :bad_request}
end
