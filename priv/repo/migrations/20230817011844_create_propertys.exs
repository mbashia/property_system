defmodule PropertySystem.Repo.Migrations.CreatePropertys do
  use Ecto.Migration

  def change do
    create table(:propertys) do
      add :name, :string
      add :address, :string
      add :type, :string
      add :status, :string
      add :size, :float
      add :description, :text
      add :user_id, :integer
      add :manager_id, :integer, default: 0

      timestamps()
    end

    create index(:propertys, [:user_id])
  end
end
