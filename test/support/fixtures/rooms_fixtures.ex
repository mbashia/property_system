defmodule PropertySystem.RoomsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `PropertySystem.Rooms` context.
  """

  @doc """
  Generate a room.
  """
  def room_fixture(attrs \\ %{}) do
    {:ok, room} =
      attrs
      |> Enum.into(%{
        description: "some description",
        floor_number: 42,
        rent_amount: 120.5,
        room_number: 42,
        size: 120.5,
        status: "some status"
      })
      |> PropertySystem.Rooms.create_room()

    room
  end
end
