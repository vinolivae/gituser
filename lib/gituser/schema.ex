defmodule Gituser.Schema do
  @moduledoc """
  This module is resposible for inject commons schema attributes and modules.
  """

  defmacro __using__(_opts) do
    quote do
      use Ecto.Schema
      import Ecto.Changeset

      @primary_key {:id, :binary_id, autogenerate: true}
    end
  end
end
