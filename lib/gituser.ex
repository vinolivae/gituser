defmodule Gituser do
  @moduledoc """
  Gituser keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  alias Gituser.User.Commands.CreateUser
  alias Gituser.User.Commands.ListUserData

  defdelegate list_users(user_name), to: ListUserData, as: :execute
  defdelegate create_user(params), to: CreateUser, as: :execute
end
