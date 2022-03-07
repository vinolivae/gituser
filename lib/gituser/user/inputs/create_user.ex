defmodule Gituser.User.Inputs.CreateUser do
  @moduledoc """
  This module contains the inputs for the validate a user before its created.
  """
  use Gituser.EmbeddedSchema

  @required [:password]

  embedded_schema do
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
