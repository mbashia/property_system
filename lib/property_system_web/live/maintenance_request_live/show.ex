defmodule PropertySystemWeb.Maintenance_requestLive.Show do
  use PropertySystemWeb, :live_view

  alias PropertySystem.Maintenance_requests

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:maintenance_request, Maintenance_requests.get_maintenance_request!(id))}
  end

  defp page_title(:show), do: "Show Maintenance request"
  defp page_title(:edit), do: "Edit Maintenance request"
end
