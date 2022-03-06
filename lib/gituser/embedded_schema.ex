defmodule Gituser.EmbeddedSchema do
  @moduledoc """
  This module is resposible for inject commons embedded schema attributes and modules.

  It's commonly used for validade if changeset is valid before insert into database.
  """

  defmacro __using__(_opts) do
    quote do
      use Ecto.Schema
      import Ecto.Changeset

      @primary_key false
    end
  end
end
