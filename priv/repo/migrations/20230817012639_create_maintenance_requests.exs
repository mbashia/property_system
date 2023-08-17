defmodule PropertySystem.Repo.Migrations.CreateMaintenanceRequests do
  use Ecto.Migration

  def change do
    create table(:maintenance_requests) do
      add :request_date, :date
      add :description, :text
      add :status, :string

      timestamps()
    end
  end
end
