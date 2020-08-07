defmodule MysimplelistWeb.ListItemLive.Index do
  use MysimplelistWeb, :live_view

  alias Mysimplelist.Lists
  alias Mysimplelist.Lists.ListItem

  @impl true
  def mount(_params, _session, socket) do
    list_items = list_list_items()
    lists = Lists.list_lists()

    {:ok, assign(socket, list_items: list_items, lists: lists)}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit List item")
    |> assign(:list_item, Lists.get_list_item!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New List item")
    |> assign(:list_item, %ListItem{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing List items")
    |> assign(:list_item, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    list_item = Lists.get_list_item!(id)
    {:ok, _} = Lists.delete_list_item(list_item)

    {:noreply, assign(socket, :list_items, list_list_items())}
  end

  defp list_list_items do
    Lists.list_list_items()
  end
end
