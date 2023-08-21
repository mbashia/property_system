defmodule PropertySystem.Repo.Migrations.AddTenantsTable do
  use Ecto.Migration

  def change do
    create table(:tenants) do
      add :user_id, :integer
      add :room_id, :integer
      add :room_name, :string
    end
  end
end
