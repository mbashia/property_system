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

      timestamps()
    end
  end
end
