defmodule PropertySystem.Repo.Migrations.AddTenantsTable do
  use Ecto.Migration

  def change do
    create table(:tenants) do
      add :user_id, :integer
      add :room_id, :integer
      add :landlord_id, :integer
      add :property_id, :integer
    end

    create index(:tenants, [:user_id])
  end
end
