defmodule PropertySystemWeb.Maintenance_requestLive.Index do
  use PropertySystemWeb, :live_view

  alias PropertySystem.Maintenance_requests
  alias PropertySystem.Maintenance_requests.Maintenance_request
  alias PropertySystem.Accounts
  alias PropertySystem.Tenants

  @impl true
  def mount(_params, session, socket) do
    current_tenant = Accounts.get_user_by_session_token(session["user_token"])
    tenant_room = Tenants.get_room_by_tenant_id(current_tenant.id)
    IO.inspect(tenant_room)

    {:ok,
     socket
     |> assign(:current_tenant, current_tenant)
     |> assign(:tenant_room, tenant_room)
     |> assign(:maintenance_requests, list_maintenance_requests())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Maintenance request")
    |> assign(:maintenance_request, Maintenance_requests.get_maintenance_request!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Maintenance request")
    |> assign(:maintenance_request, %Maintenance_request{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Maintenance requests")
    |> assign(:maintenance_request, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    maintenance_request = Maintenance_requests.get_maintenance_request!(id)
    {:ok, _} = Maintenance_requests.delete_maintenance_request(maintenance_request)

    {:noreply, assign(socket, :maintenance_requests, list_maintenance_requests())}
  end

  defp list_maintenance_requests do
    Maintenance_requests.list_maintenance_requests()
  end
end
