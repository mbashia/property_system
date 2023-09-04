defmodule PropertySystemWeb.Maintenance_requestLive.FormComponent do
  use PropertySystemWeb, :live_component

  alias PropertySystem.Maintenance_requests

  @impl true
  def update(%{maintenance_request: maintenance_request} = assigns, socket) do
    changeset = Maintenance_requests.change_maintenance_request(maintenance_request)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"maintenance_request" => maintenance_request_params}, socket) do
    changeset =
      socket.assigns.maintenance_request
      |> Maintenance_requests.change_maintenance_request(maintenance_request_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"maintenance_request" => maintenance_request_params}, socket) do
    save_maintenance_request(socket, socket.assigns.action, maintenance_request_params)
  end

  defp save_maintenance_request(socket, :edit, maintenance_request_params) do
    case Maintenance_requests.update_maintenance_request(
           socket.assigns.maintenance_request,
           maintenance_request_params
         ) do
      {:ok, _maintenance_request} ->
        {:noreply,
         socket
         |> put_flash(:info, "Maintenance request updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_maintenance_request(socket, :new, maintenance_request_params) do
    IO.write("socket assigns starts here")
    IO.inspect(maintenance_request_params)

    maintenance_request_params =
      Map.put(maintenance_request_params, "user_id", socket.assigns.current_tenant.id)

    maintenance_request_params =
      Map.put(maintenance_request_params, "room_id", socket.assigns.tenant_room.id)

    maintenance_request_params =
      Map.put(maintenance_request_params, "property_id", socket.assigns.tenant_room.property.id)

    IO.inspect(maintenance_request_params)

    case Maintenance_requests.create_maintenance_request(maintenance_request_params) do
      {:ok, _maintenance_request} ->
        {:noreply,
         socket
         |> put_flash(:info, "Maintenance request created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
