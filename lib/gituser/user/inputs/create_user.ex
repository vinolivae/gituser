defmodule Gituser.User.Inputs.CreateUser do
  use Gituser.EmbeddedSchema

  @required [:password]

  embedded_schema do
    field :password, :string
  end

  def changeset(model \\ %__MODULE__{}, params) do
    model
    |> cast(params, @required)
    |> validate_required(@required)
    |> validate_length(:password, min: 6)
  end
end
