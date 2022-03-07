defmodule Gituser.User.Inputs.Signin do
  use Gituser.EmbeddedSchema

  @required [:id, :password]

  embedded_schema do
    field :id, Ecto.UUID
    field :password, :string
  end

  def changeset(model \\ %__MODULE__{}, params) do
    model
    |> cast(params, @required)
    |> validate_required(@required)
    |> validate_length(:password, min: 6)
  end
end
