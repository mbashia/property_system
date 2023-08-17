defmodule PropertySystem.Repo.Migrations.CreateRooms do
  use Ecto.Migration

  def change do
    create table(:rooms) do
      add :room_number, :integer
      add :rent_amount, :float
      add :size, :float
      add :description, :text
      add :status, :string
      add :floor_number, :integer

      timestamps()
    end
  end
end
