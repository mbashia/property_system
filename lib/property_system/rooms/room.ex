defmodule PropertySystem.Rooms.Room do
  use Ecto.Schema
  import Ecto.Changeset

  schema "rooms" do
    field :description, :string
    field :floor_number, :integer
    field :rent_amount, :float
    field :room_number, :integer
    field :size, :float
    field :status, :string

    timestamps()
  end

  @doc false
  def changeset(room, attrs) do
    room
    |> cast(attrs, [:room_number, :rent_amount, :size, :description, :status, :floor_number])
    |> validate_required([:room_number, :rent_amount, :size, :description, :status, :floor_number])
  end
end
