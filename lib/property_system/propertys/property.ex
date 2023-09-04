defmodule PropertySystem.Propertys.Property do
  use Ecto.Schema
  import Ecto.Changeset
  alias PropertySystem.Accounts.User
  alias PropertySystem.Rooms.Room
  alias PropertySystem.Maintenance_requests.Maintenance_request

  schema "propertys" do
    field :address, :string
    field :description, :string
    field :name, :string
    field :size, :float
    field :status, :string
    field :type, :string
    field :manager_id, :integer, default: 0

    belongs_to :user, User, foreign_key: :user_id
    has_many :rooms, Room
    has_many :maitenance_requests, Maintenance_request

    timestamps()
  end

  @doc false
  def changeset(property, attrs) do
    property
    |> cast(attrs, [:name, :address, :type, :status, :size, :description, :user_id, :manager_id])
    |> validate_required([
      :name,
      :address,
      :type,
      :status,
      :size,
      :description,
      :user_id,
      :manager_id
    ])
  end
end
