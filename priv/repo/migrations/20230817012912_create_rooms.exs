defmodule PropertySystem.Repo.Migrations.CreateRooms do
  use Ecto.Migration

  def change do
    create table(:rooms) do
      add :room_name, :string
      add :rent_amount, :float
      add :size, :float
      add :description, :text
      add :status, :string
      add :floor_number, :integer
      add :property_id, :integer

      timestamps()
    end
  end
end
