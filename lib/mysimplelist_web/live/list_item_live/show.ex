defmodule MysimplelistWeb.ListItemLive.Show do
  use MysimplelistWeb, :live_view

  alias Mysimplelist.Lists

  @impl true
  def mount(_params, %{"current_user_token" => current_user_token}, socket) do
    lists = Lists.list_lists()
    {:ok, assign(socket, lists: lists, current_user_token: current_user_token)}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:list_item, Lists.get_list_item!(id))}
  end

  defp page_title(:show), do: "Show List item"
  defp page_title(:edit), do: "Edit List item"
end
