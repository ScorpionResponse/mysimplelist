defmodule MysimplelistWeb.ListItemLive.FormComponent do
  use MysimplelistWeb, :live_component

  alias Mysimplelist.Lists

  @impl true
  def update(%{list_item: list_item} = assigns, socket) do
    changeset = Lists.change_list_item(list_item)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"list_item" => list_item_params}, socket) do
    changeset =
      socket.assigns.list_item
      |> Lists.change_list_item(list_item_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"list_item" => list_item_params}, socket) do
    save_list_item(socket, socket.assigns.action, list_item_params)
  end

  defp save_list_item(socket, :edit, list_item_params) do
    case Lists.update_list_item(socket.assigns.list_item, list_item_params) do
      {:ok, _list_item} ->
        {:noreply,
         socket
         |> put_flash(:info, "List item updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_list_item(socket, :new, list_item_params) do
    case Lists.create_list_item(list_item_params) do
      {:ok, _list_item} ->
        {:noreply,
         socket
         |> put_flash(:info, "List item created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
