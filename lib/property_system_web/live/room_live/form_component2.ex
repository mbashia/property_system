defmodule PropertySystemWeb.RoomLive.FormComponent2 do
  use PropertySystemWeb, :live_component
  alias PropertySystem.Accounts
  alias PropertySystem.Accounts.User
  alias PropertySystem.Tenants
  alias PropertySystem.Accounts.UserNotifier

  def update(%{user: user} = assigns, socket) do
    tenant_changeset = Accounts.change_user_registration(user)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:tenant_changeset, tenant_changeset)
     |> assign(:email_error, "")
     |> assign(:disable_save, false)}
  end

  def handle_event("save", %{"user" => user_params}, socket) do
    room = socket.assigns.room
    current_user_id = socket.assigns.current_user.id
    user_params = Map.put(user_params, "role", "tenant")

    case Accounts.register_user(user_params) do
      {:ok, user} ->
        {:ok, _} =
          UserNotifier.deliver_login_credentials(
            user_params["email"],
            user_params["password"]
          )

        tenant_params = %{
          "user_id" => user.id,
          "room_id" => room.id,
          "landlord_id" => current_user_id,
          "property_id" => room.property.id
        }

        case Tenants.create_entry(tenant_params) do
          {:ok, _params} ->
            {:noreply,
             socket
             |> put_flash(:info, "Tenant added successfully")
             |> push_redirect(to: socket.assigns.return_to)}

          {:error, %Ecto.Changeset{} = changeset} ->
            {:noreply, assign(socket, changeset: changeset)}
        end

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end

  def handle_event("validate", %{"user" => user_params}, socket) do
    changeset =
      socket.assigns.user
      |> Accounts.change_user_registration(user_params)
      |> Map.put(:action, :validate)

    emails = Accounts.get_emails()
    user_email = user_params["email"]

    email_error =
      if user_email in emails do
        "email already exists"
      else
        nil
      end

    disable_save =
      if email_error != nil do
        true
      else
        false
      end

    {:noreply,
     socket
     |> assign(:changeset, changeset)
     |> assign(:email_error, email_error)
     |> assign(:disable_save, disable_save)}
  end
end
