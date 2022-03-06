defmodule Gituser.User.Commands.CreateUserTest do
  use Gituser.DataCase, async: true

  alias Gituser.User.Commands.CreateUser

  describe "exeucute/1" do
    test "succeeds if params are correct" do
      assert {:ok,
              %Gituser.Schemas.User{
                id: _,
                inserted_at: %NaiveDateTime{},
                password: "123456",
                password_hash: _,
                updated_at: %NaiveDateTime{}
              }} = CreateUser.execute(%{password: "123456"})
    end
  end
end
