defmodule MysimplelistWeb.ListLive.Index do
  use MysimplelistWeb, :live_view

  alias Mysimplelist.Lists
  alias Mysimplelist.Lists.List

  @impl true
  def mount(_params, %{"current_user_token" => current_user_token}, socket) do
    {:ok, assign(socket, lists: list_lists(), current_user_token: current_user_token)}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit List")
    |> assign(:list, Lists.get_list!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New List")
    |> assign(:list, %List{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Lists")
    |> assign(:list, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    list = Lists.get_list!(id)
    {:ok, _} = Lists.delete_list(list)

    {:noreply, assign(socket, :lists, list_lists())}
  end

  defp list_lists do
    Lists.list_lists()
  end
end
