defmodule PropertySystemWeb.RoomLive.FormComponent do
  use PropertySystemWeb, :live_component

  alias PropertySystem.Rooms

  @impl true
  def update(%{room: room} = assigns, socket) do
    changeset = Rooms.change_room(room)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true

  def handle_event("validate", %{"room" => room_params}, socket) do
    changeset =
      socket.assigns.room
      |> Rooms.change_room(room_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"room" => room_params}, socket) do
    save_room(socket, socket.assigns.action, room_params)
  end

  defp save_room(socket, :edit, room_params) do
    case Rooms.update_room(socket.assigns.room, room_params) do
      {:ok, _room} ->
        {:noreply,
         socket
         |> put_flash(:info, "Room updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_room(socket, :add_room, room_params) do
    # property_id = socket.assigns.property_id
    # room_params = Map.put(room_params, "property_id", socket.assigns.property.id)
    # room_params = Map.put(room_params, "user_id", socket.assigns.current_user.id)
    room_params =
      room_params
      |> Map.put("property_id", socket.assigns.property.id)
      |> Map.put("user_id", socket.assigns.current_user.id)

    case Rooms.create_room(room_params) do
      {:ok, _room} ->
        {:noreply,
         socket
         |> put_flash(:info, "Room created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
