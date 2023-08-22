defmodule PropertySystem.Rooms.Room do
  use Ecto.Schema
  import Ecto.Changeset
  alias PropertySystem.Propertys.Property
  alias PropertySystem.Tenants.Tenant

  schema "rooms" do
    field :description, :string
    field :floor_number, :integer
    field :rent_amount, :float
    field :room_name, :string
    field :size, :float
    field :status, :string
    belongs_to :property, Property, foreign_key: :property_id
    has_many :tenants, Tenant

    timestamps()
  end

  def changeset(room, attrs) do
    room
    |> cast(attrs, [
      :room_name,
      :rent_amount,
      :size,
      :description,
      :status,
      :floor_number,
      :property_id
    ])
    |> validate_required([
      :room_name,
      :rent_amount,
      :size,
      :description,
      :status,
      :floor_number,
      :property_id
    ])
  end
end
