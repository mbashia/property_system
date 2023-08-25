defmodule PropertySystem.Repo.Migrations.CreateMaintenanceRequests do
  use Ecto.Migration

  def change do
    create table(:maintenance_requests) do
      add :request_date, :date
      add :description, :text
      add :status, :string
      add  :user_id, :integer
      add :property_id, :integer
      add :room_id, :integer

      timestamps()
    end
  end
end
