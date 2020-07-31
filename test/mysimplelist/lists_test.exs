defmodule Mysimplelist.ListsTest do
  use Mysimplelist.DataCase

  alias Mysimplelist.Lists

  describe "lists" do
    alias Mysimplelist.Lists.List

    @valid_attrs %{name: "some name", uuid: "7488a646-e31f-11e4-aace-600308960662"}
    @update_attrs %{name: "some updated name", uuid: "7488a646-e31f-11e4-aace-600308960668"}
    @invalid_attrs %{name: nil, uuid: nil}

    def list_fixture(attrs \\ %{}) do
      {:ok, list} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Lists.create_list()

      list
    end

    test "list_lists/0 returns all lists" do
      list = list_fixture()
      assert Lists.list_lists() == [list]
    end

    test "get_list!/1 returns the list with given id" do
      list = list_fixture()
      assert Lists.get_list!(list.id) == list
    end

    test "create_list/1 with valid data creates a list" do
      assert {:ok, %List{} = list} = Lists.create_list(@valid_attrs)
      assert list.name == "some name"
      assert list.uuid == "7488a646-e31f-11e4-aace-600308960662"
    end

    test "create_list/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Lists.create_list(@invalid_attrs)
    end

    test "update_list/2 with valid data updates the list" do
      list = list_fixture()
      assert {:ok, %List{} = list} = Lists.update_list(list, @update_attrs)
      assert list.name == "some updated name"
      assert list.uuid == "7488a646-e31f-11e4-aace-600308960668"
    end

    test "update_list/2 with invalid data returns error changeset" do
      list = list_fixture()
      assert {:error, %Ecto.Changeset{}} = Lists.update_list(list, @invalid_attrs)
      assert list == Lists.get_list!(list.id)
    end

    test "delete_list/1 deletes the list" do
      list = list_fixture()
      assert {:ok, %List{}} = Lists.delete_list(list)
      assert_raise Ecto.NoResultsError, fn -> Lists.get_list!(list.id) end
    end

    test "change_list/1 returns a list changeset" do
      list = list_fixture()
      assert %Ecto.Changeset{} = Lists.change_list(list)
    end
  end

  describe "list_items" do
    alias Mysimplelist.Lists.ListItem

    @valid_attrs %{
      details: "some details",
      title: "some title",
      uuid: "7488a646-e31f-11e4-aace-600308960662"
    }
    @update_attrs %{
      details: "some updated details",
      title: "some updated title",
      uuid: "7488a646-e31f-11e4-aace-600308960668"
    }
    @invalid_attrs %{details: nil, title: nil, uuid: nil}

    def list_item_fixture(attrs \\ %{}) do
      {:ok, list_item} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Lists.create_list_item()

      list_item
    end

    test "list_list_items/0 returns all list_items" do
      list_item = list_item_fixture()
      assert Lists.list_list_items() == [list_item]
    end

    test "get_list_item!/1 returns the list_item with given id" do
      list_item = list_item_fixture()
      assert Lists.get_list_item!(list_item.id) == list_item
    end

    test "create_list_item/1 with valid data creates a list_item" do
      assert {:ok, %ListItem{} = list_item} = Lists.create_list_item(@valid_attrs)
      assert list_item.details == "some details"
      assert list_item.title == "some title"
      assert list_item.uuid == "7488a646-e31f-11e4-aace-600308960662"
    end

    test "create_list_item/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Lists.create_list_item(@invalid_attrs)
    end

    test "update_list_item/2 with valid data updates the list_item" do
      list_item = list_item_fixture()
      assert {:ok, %ListItem{} = list_item} = Lists.update_list_item(list_item, @update_attrs)
      assert list_item.details == "some updated details"
      assert list_item.title == "some updated title"
      assert list_item.uuid == "7488a646-e31f-11e4-aace-600308960668"
    end

    test "update_list_item/2 with invalid data returns error changeset" do
      list_item = list_item_fixture()
      assert {:error, %Ecto.Changeset{}} = Lists.update_list_item(list_item, @invalid_attrs)
      assert list_item == Lists.get_list_item!(list_item.id)
    end

    test "delete_list_item/1 deletes the list_item" do
      list_item = list_item_fixture()
      assert {:ok, %ListItem{}} = Lists.delete_list_item(list_item)
      assert_raise Ecto.NoResultsError, fn -> Lists.get_list_item!(list_item.id) end
    end

    test "change_list_item/1 returns a list_item changeset" do
      list_item = list_item_fixture()
      assert %Ecto.Changeset{} = Lists.change_list_item(list_item)
    end
  end
end
