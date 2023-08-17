defmodule PropertySystemWeb.PropertyLive.Show do
  use PropertySystemWeb, :live_view

  alias PropertySystem.Propertys
  alias PropertySystem.Rooms.Room
  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
    |> assign(:page_title, page_title(socket.assigns.live_action))
    |> assign(:room, %Room{})
     |> assign(:property, Propertys.get_property!(id))}
  end

  defp page_title(:show), do: "Show Property"
  defp page_title(:edit), do: "Edit Property"

  defp page_title(:add_room), do: "Add Room"
end
