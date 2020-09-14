defmodule Mysimplelist.Tests.Fixtures do
  @moduledoc """
  Define fixtures used in various tests.
  """

  alias Mysimplelist.{Accounts, Lists}

  @valid_user_attrs %{email: "some@valid.email", name: "some name"}
  @valid_list_attrs %{name: "some name"}
  @valid_list_item_attrs %{
    title: "some title",
    details: "some details",
    complete: false
  }

  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(@valid_user_attrs)
      |> Accounts.create_user()

    user
  end

  def list_fixture(attrs \\ %{}) do
    user =
      case attrs do
        %{:user => user_attr} ->
          user_attr

        %{:user_id => user_id} ->
          Accounts.get_user!(user_id)

        _ ->
          user_fixture()
      end

    {:ok, list} =
      attrs
      |> Enum.into(@valid_list_attrs)
      |> (&Lists.create_list(user, &1)).()

    list
  end

  def list_item_fixture(attrs \\ %{}) do
    list_id =
      case attrs do
        %{:list => list} ->
          list.id

        %{:list_id => list_id} ->
          list_id

        _ ->
          list_fixture().id
      end

    composed_attrs = Map.put(@valid_list_item_attrs, :list_id, list_id)

    {:ok, list_item} =
      attrs
      |> Enum.into(composed_attrs)
      |> Lists.create_list_item()

    list_item
  end
end
