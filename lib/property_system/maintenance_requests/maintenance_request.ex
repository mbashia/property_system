defmodule PropertySystem.Maintenance_requests.Maintenance_request do
  use Ecto.Schema
  import Ecto.Changeset
  alias PropertySystem.Accounts.User
  alias PropertySystem.Propertys.Property
  alias PropertySystem.Rooms.Room



  schema "maintenance_requests" do
    field :description, :string
    field :request_date, :date
    field :status, :string
    belongs_to :user, User, foreign_key: :user_id
    belongs_to :property, Property, foreign_key: :property_id
    belongs_to :room, Room, foreign_key: :room_id




    timestamps()
  end

  @doc false
  def changeset(maintenance_request, attrs) do
    maintenance_request
    |> cast(attrs, [:request_date, :description, :status,:user_id, :property_id , :room_id])
    |> validate_required([:request_date, :description, :status,:user_id, :property_id, :room_id])
  end
end
