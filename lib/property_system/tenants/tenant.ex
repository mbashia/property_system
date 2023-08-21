defmodule PropertySystem.Tenants.Tenant do
  use Ecto.Schema
  import Ecto.Changeset
  alias PropertySystem.Accounts.User
  alias PropertySystem.Accounts.User
  alias PropertySystem.Rooms.Room

  schema "tenants" do
    belongs_to :user, User, foreign_key: :user_id
    belongs_to :room, Room, foreign_key: :room_id
    field :room_name, :string
  end

  def changeset(tenant, attrs) do
    tenant
    |> cast(attrs, [:user_id, :room_id, :room_name])
    |> validate_required([:user_id, :room_id,:room_name])
  end
end
