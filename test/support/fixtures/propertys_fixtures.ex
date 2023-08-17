defmodule PropertySystem.PropertysFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `PropertySystem.Propertys` context.
  """

  @doc """
  Generate a property.
  """
  def property_fixture(attrs \\ %{}) do
    {:ok, property} =
      attrs
      |> Enum.into(%{
        address: "some address",
        description: "some description",
        name: "some name",
        size: 120.5,
        status: "some status",
        type: "some type"
      })
      |> PropertySystem.Propertys.create_property()

    property
  end
end
