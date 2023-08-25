defmodule PropertySystemWeb.PropertyLive.ManagerComponent do
  use PropertySystemWeb, :live_component
  alias PropertySystem.Accounts
  alias PropertySystem.Accounts.User
  alias PropertySystem.Accounts.UserNotifier

  alias PropertySystem.Propertys

  def update(%{user: user} = assigns, socket) do
   manager_changeset = Accounts.change_user_registration(user)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:manager_changeset, manager_changeset)
     |> assign(:email_error, "")
     |> assign(:disable_save, false)}
  end

  def handle_event("save", %{"user" => user_params}, socket) do
    user_params = Map.put(user_params, "role", "manager")
    house_name= socket.assigns.property.name


    case Accounts.register_user(user_params) do
      {:ok, user} ->
        {:ok, _} =
          UserNotifier.deliver_manager_credentials(
            user_params["email"],
            user_params["password"],
            house_name
          )
          update_params = %{"manager_id" => user.id}

          case Propertys.update_property(socket.assigns.property, update_params) do
            {:ok, _property} ->
              {:noreply,
               socket
               |> put_flash(:info, "Property updated successfully")
               |> push_redirect(to: socket.assigns.return_to)}

            {:error, %Ecto.Changeset{} = changeset} ->
              {:noreply, assign(socket, :changeset, changeset)}
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
