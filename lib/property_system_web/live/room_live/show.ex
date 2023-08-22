defmodule PropertySystemWeb.RoomLive.Show do
  use PropertySystemWeb, :live_view

  alias PropertySystem.Rooms
  alias PropertySystem.Accounts.User

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  @spec handle_params(map, any, %{
          :assigns => atom | %{:live_action => :add_tenant | :edit | :show, optional(any) => any},
          optional(any) => any
        }) :: {:noreply, map}
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:room, Rooms.get_room!(id))
     |> assign(:user, %User{})}
  end

  defp page_title(:show), do: "Show Room"
  defp page_title(:edit), do: "Edit Room"
  defp page_title(:add_tenant), do: "add tenant"
end
