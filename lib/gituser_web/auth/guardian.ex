defmodule GituserWeb.Auth.Guardian do
  use Guardian, otp_app: :gituser

  alias Gituser.Schemas.User
  alias Gituser.User.Commands.GetUser

  def subject_for_token(%User{id: id}, _claims), do: {:ok, id}

  def resource_from_claims(claims) do
    claims
    |> Map.get("sub")
    |> GetUser.by_id()
  end

  def authenticate(%{id: user_id, password: password}) do
    with {:ok, %User{password_hash: hash} = user} <- GetUser.by_id(user_id),
         {:valid_pass?, true} <- {:valid_pass?, Pbkdf2.verify_pass(password, hash)},
         {:ok, token, _claims} <- encode_and_sign(user) do
      {:ok, token}
    else
      {:valid_pass?, false} -> {:error, :unauthorized}
      error -> error
    end
  end

  def authenticate(_), do: {:error, :bad_request}
end
