defmodule PropertySystem.Users do
  alias PropertySystem.Accounts.User
  import Ecto.Query, warn: false
  alias PropertySystem.Repo




  def get_manager(id) do
    Repo.all(
      from(u in User, where: u.id == ^id and u.role == ^"manager")
    )  end
end
