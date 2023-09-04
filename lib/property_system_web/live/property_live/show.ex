defmodule PropertySystemWeb.PropertyLive.Show do
  use PropertySystemWeb, :live_view

  alias PropertySystem.Propertys
  alias PropertySystem.Rooms.Room
  alias PropertySystem.Accounts
  alias PropertySystem.Accounts.User

  @impl true
  def mount(_params, session, socket) do
    current_user = Accounts.get_user_by_session_token(session["user_token"])

    {:ok,
     socket
     |> assign(:room, %Room{})
     |> assign(:current_user, current_user)
     |> assign(:user, %User{})}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:property, Propertys.get_property!(id))}
  end

  defp page_title(:show), do: "Show Property"
  defp page_title(:edit), do: "Edit Property"

  defp page_title(:add_room), do: "Add Room"
  defp page_title(:add_manager), do: "Add Manager"
end
