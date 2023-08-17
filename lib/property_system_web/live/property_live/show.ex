defmodule PropertySystemWeb.PropertyLive.Show do
  use PropertySystemWeb, :live_view

  alias PropertySystem.Propertys

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |>assign(:property_id, id)
    |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:property, Propertys.get_property!(id))}
  end

  defp page_title(:show), do: "Show Property"
  defp page_title(:edit), do: "Edit Property"
end
