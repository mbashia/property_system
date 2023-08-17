defmodule PropertySystem.Propertys.Property do
  use Ecto.Schema
  import Ecto.Changeset
  alias PropertySystem.Accounts.User

  schema "propertys" do
    field :address, :string
    field :description, :string
    field :name, :string
    field :size, :float
    field :status, :string
    field :type, :string
    belongs_to :user, User, foreign_key:  :user_id



    timestamps()
  end

  @doc false
  def changeset(property, attrs) do
    property
    |> cast(attrs, [:name, :address, :type, :status, :size, :description, :user_id])
    |> validate_required([:name, :address, :type, :status, :size, :description, :user_id])
  end
end
