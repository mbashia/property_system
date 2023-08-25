defmodule PropertySystemWeb.RoomLive.Show do
  use PropertySystemWeb, :live_view

  alias PropertySystem.Rooms
  alias PropertySystem.Accounts.User
  alias PropertySystem.Accounts

  @impl true
  def mount(_params, session, socket) do
    current_user = Accounts.get_user_by_session_token(session["user_token"])
    {:ok, socket
           |>assign(:current_user, current_user)}
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
