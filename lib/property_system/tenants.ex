defmodule PropertySystem.Tenants do
  alias PropertySystem.Tenants.Tenant
  alias PropertySystem.Rooms.Room
  alias PropertySystem.Rooms
  import Ecto.Query, warn: false
  alias PropertySystem.Repo

  def create_entry(attrs \\ %{}) do
    %Tenant{}
    |> Tenant.changeset(attrs)
    |> Repo.insert()
  end

  @spec change_tenant(any, any) :: none
  def change_tenant(%Tenant{} = tenant, attrs \\ %{}) do
    Tenant.changeset(tenant, attrs)
  end
  def list_tenants do
    Repo.all(Tenant)
    |>Repo.preload(:user)
  end

  def get_room_by_tenant_id(id) do
   room= Repo.one(from t in Tenant, where: t.user_id == ^id)
   IO.write("room starts here")
   IO.inspect(room.room_id)
   Rooms.get_room!(room.room_id)
  end
end
