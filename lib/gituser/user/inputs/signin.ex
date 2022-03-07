defmodule Gituser.User.Inputs.Signin do
  @moduledoc """
  This module contains the inputs for the validate a user before its signined.
  """
  use Gituser.EmbeddedSchema

  @required [:id, :password]

  embedded_schema do
    field :id, Ecto.UUID
    field :password, :string
  end

  @doc false
  def changeset(model \\ %__MODULE__{}, params) do
    model
    |> cast(params, @required)
    |> validate_required(@required)
    |> validate_length(:password, min: 6)
  end
end
