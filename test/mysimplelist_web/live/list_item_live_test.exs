defmodule MysimplelistWeb.ListItemLiveTest do
  use MysimplelistWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Mysimplelist.Lists

  @create_attrs %{
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

  defp fixture(:list_item) do
    {:ok, list_item} = Lists.create_list_item(@create_attrs)
    list_item
  end

  defp create_list_item(_) do
    list_item = fixture(:list_item)
    %{list_item: list_item}
  end

  describe "Index" do
    setup [:create_list_item]

    test "lists all list_items", %{conn: conn, list_item: list_item} do
      {:ok, _index_live, html} = live(conn, Routes.list_item_index_path(conn, :index))

      assert html =~ "Listing List items"
      assert html =~ list_item.details
    end

    test "saves new list_item", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.list_item_index_path(conn, :index))

      assert index_live |> element("a", "New List item") |> render_click() =~
               "New List item"

      assert_patch(index_live, Routes.list_item_index_path(conn, :new))

      assert index_live
             |> form("#list_item-form", list_item: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#list_item-form", list_item: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.list_item_index_path(conn, :index))

      assert html =~ "List item created successfully"
      assert html =~ "some details"
    end

    test "updates list_item in listing", %{conn: conn, list_item: list_item} do
      {:ok, index_live, _html} = live(conn, Routes.list_item_index_path(conn, :index))

      assert index_live |> element("#list_item-#{list_item.id} a", "Edit") |> render_click() =~
               "Edit List item"

      assert_patch(index_live, Routes.list_item_index_path(conn, :edit, list_item))

      assert index_live
             |> form("#list_item-form", list_item: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#list_item-form", list_item: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.list_item_index_path(conn, :index))

      assert html =~ "List item updated successfully"
      assert html =~ "some updated details"
    end

    test "deletes list_item in listing", %{conn: conn, list_item: list_item} do
      {:ok, index_live, _html} = live(conn, Routes.list_item_index_path(conn, :index))

      assert index_live |> element("#list_item-#{list_item.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#list_item-#{list_item.id}")
    end
  end

  describe "Show" do
    setup [:create_list_item]

    test "displays list_item", %{conn: conn, list_item: list_item} do
      {:ok, _show_live, html} = live(conn, Routes.list_item_show_path(conn, :show, list_item))

      assert html =~ "Show List item"
      assert html =~ list_item.details
    end

    test "updates list_item within modal", %{conn: conn, list_item: list_item} do
      {:ok, show_live, _html} = live(conn, Routes.list_item_show_path(conn, :show, list_item))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit List item"

      assert_patch(show_live, Routes.list_item_show_path(conn, :edit, list_item))

      assert show_live
             |> form("#list_item-form", list_item: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#list_item-form", list_item: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.list_item_show_path(conn, :show, list_item))

      assert html =~ "List item updated successfully"
      assert html =~ "some updated details"
    end
  end
end
