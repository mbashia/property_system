defmodule PropertySystemWeb.RoomLive.FormComponent2 do
  use PropertySystemWeb, :live_component
  alias PropertySystem.Accounts
  alias PropertySystem.Accounts.User
  alias PropertySystem.Tenants

  def update(%{user: user}=assigns, socket) do
    tenant_changeset = Accounts.change_user_registration(user)
    IO.inspect(tenant_changeset)
    {:ok,
     socket
     |> assign(assigns)
     |> assign(:tenant_changeset, tenant_changeset)}
  end

  @spec handle_event(
          <<_::32, _::_*32>>,
          map,
          atom
          | %{:assigns => atom | %{:room => any, optional(any) => any}, optional(any) => any}
        ) :: {:noreply, atom | map}
  def handle_event("save", %{"user" => user_params}, socket) do
    room =socket.assigns.room
    IO.inspect(room.room_name)
    user_params = Map.put(user_params, "role", "tenant")

    case Accounts.register_user(user_params) do
      {:ok, user} ->

        tenant_params = %{"user_id"=> user.id,"room_id"=>room.id, "room_name"=>room.room_name}
         Tenants.create_entry(tenant_params)
          IO.write("already passed")
          IO.inspect(socket)
          {:noreply,
          socket
          |> put_flash(:info, "Tenant successfully")
          |> push_redirect(to: socket.assigns.return_to)}


    end


  end
  def handle_event("validate", %{"user" => user_params}, socket) do
    changeset =
      socket.assigns.user
      |>Accounts.change_user_registration(user_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end
end
