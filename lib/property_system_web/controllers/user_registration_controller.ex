defmodule PropertySystemWeb.UserRegistrationController do
  use PropertySystemWeb, :controller

  alias PropertySystem.Accounts
  alias PropertySystem.Accounts.User
  alias PropertySystemWeb.UserAuth

  def new(conn, _params) do
    changeset = Accounts.change_user_registration(%User{})
    render(conn, "new.html", changeset: changeset)
  end

  def newtenant(conn, _params) do
    changeset = Accounts.change_user_registration(%User{})
    render(conn, "tenant.html", changeset: changeset)
  end

  def newmanager(conn, _params) do
    changeset = Accounts.change_user_registration(%User{})
    render(conn, "manager.html", changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    user_params = Map.put(user_params, "role", "landlord")

    case Accounts.register_user(user_params) do
      {:ok, user} ->
        {:ok, _} =
          Accounts.deliver_user_confirmation_instructions(
            user,
            &Routes.user_confirmation_url(conn, :edit, &1)
          )

        conn
        |> put_flash(:info, "User created successfully.")
        |> UserAuth.log_in_user(user)

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def createtenant(conn, %{"user" => user_params}) do
    user_params = Map.put(user_params, "role", "tenant")

    case Accounts.register_user(user_params) do
      {:ok, _user} ->
        conn
        |> put_flash(:info, "User created successfully.")
        |> redirect(to: "/")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "tenant.html", changeset: changeset)
    end
  end

  def createmanager(conn, %{"user" => user_params}) do
    user_params = Map.put(user_params, "role", "manager")

    case Accounts.register_user(user_params) do
      {:ok, _user} ->
        conn
        |> put_flash(:info, "User created successfully.")
        |> redirect(to: "/")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "manager.html", changeset: changeset)
    end
  end
end
