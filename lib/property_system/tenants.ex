defmodule PropertySystem.Tenants do
  alias PropertySystem.Tenants.Tenant

  import Ecto.Query, warn: false
  alias PropertySystem.Repo

  def create_entry(attrs \\ %{}) do
    %Tenant{}
    |> Tenant.changeset(attrs)
    |> Repo.insert()
  end
  def change_tenant(%Tenant{} = tenant, attrs \\ %{}) do
    Tenant.changeset(tenant, attrs)
  end
end
