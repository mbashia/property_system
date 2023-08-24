defmodule PropertySystemWeb.PropertyLive.ManagerComponent do
  use PropertySystemWeb, :live_component
  alias PropertySystem.Accounts


  def update(%{user: user} = assigns, socket) do
   manager_changeset = Accounts.change_user_registration(user)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:manager_changeset, manager_changeset)
     |> assign(:email_error, "")
     |> assign(:disable_save, false)}
  end
end
