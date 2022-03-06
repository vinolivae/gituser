defmodule Gituser.ChangesetValidation do
  @moduledoc "Helper functions for validating changesets"

  @doc " Cast and apply the given changeset and params into a struct "
  @spec cast_and_apply(schema :: module(), params :: map() | struct()) ::
          {:ok, Ecto.Schema.t()} | {:error, Changeset.t()}
  def cast_and_apply(schema, params) do
    %{}
    |> schema.__struct__()
    |> schema.changeset(params)
    |> case do
      %{valid?: true} = changeset ->
        changeset
        |> Ecto.Changeset.apply_changes()
        |> Map.from_struct()
        |> then(&{:ok, &1})

      %{valid?: false} = changeset ->
        {:error, changeset}
    end
  end
end
