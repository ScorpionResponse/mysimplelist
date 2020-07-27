defmodule MysimplelistWeb.ListItemLive.Show do
  use MysimplelistWeb, :live_view

  alias Mysimplelist.Lists

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
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
