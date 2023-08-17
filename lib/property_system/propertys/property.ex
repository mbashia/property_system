defmodule PropertySystem.Propertys.Property do
  use Ecto.Schema
  import Ecto.Changeset

  schema "propertys" do
    field :address, :string
    field :description, :string
    field :name, :string
    field :size, :float
    field :status, :string
    field :type, :string

    timestamps()
  end

  @doc false
  def changeset(property, attrs) do
    property
    |> cast(attrs, [:name, :address, :type, :status, :size, :description])
    |> validate_required([:name, :address, :type, :status, :size, :description])
  end
end
