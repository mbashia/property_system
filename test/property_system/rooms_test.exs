defmodule PropertySystem.RoomsTest do
  use PropertySystem.DataCase

  alias PropertySystem.Rooms

  describe "rooms" do
    alias PropertySystem.Rooms.Room

    import PropertySystem.RoomsFixtures

    @invalid_attrs %{
      description: nil,
      floor_number: nil,
      rent_amount: nil,
      room_number: nil,
      size: nil,
      status: nil
    }

    test "list_rooms/0 returns all rooms" do
      room = room_fixture()
      assert Rooms.list_rooms() == [room]
    end

    test "get_room!/1 returns the room with given id" do
      room = room_fixture()
      assert Rooms.get_room!(room.id) == room
    end

    test "create_room/1 with valid data creates a room" do
      valid_attrs = %{
        description: "some description",
        floor_number: 42,
        rent_amount: 120.5,
        room_number: 42,
        size: 120.5,
        status: "some status"
      }

      assert {:ok, %Room{} = room} = Rooms.create_room(valid_attrs)
      assert room.description == "some description"
      assert room.floor_number == 42
      assert room.rent_amount == 120.5
      assert room.room_number == 42
      assert room.size == 120.5
      assert room.status == "some status"
    end

    test "create_room/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Rooms.create_room(@invalid_attrs)
    end

    test "update_room/2 with valid data updates the room" do
      room = room_fixture()

      update_attrs = %{
        description: "some updated description",
        floor_number: 43,
        rent_amount: 456.7,
        room_number: 43,
        size: 456.7,
        status: "some updated status"
      }

      assert {:ok, %Room{} = room} = Rooms.update_room(room, update_attrs)
      assert room.description == "some updated description"
      assert room.floor_number == 43
      assert room.rent_amount == 456.7
      assert room.room_number == 43
      assert room.size == 456.7
      assert room.status == "some updated status"
    end

    test "update_room/2 with invalid data returns error changeset" do
      room = room_fixture()
      assert {:error, %Ecto.Changeset{}} = Rooms.update_room(room, @invalid_attrs)
      assert room == Rooms.get_room!(room.id)
    end

    test "delete_room/1 deletes the room" do
      room = room_fixture()
      assert {:ok, %Room{}} = Rooms.delete_room(room)
      assert_raise Ecto.NoResultsError, fn -> Rooms.get_room!(room.id) end
    end

    test "change_room/1 returns a room changeset" do
      room = room_fixture()
      assert %Ecto.Changeset{} = Rooms.change_room(room)
    end
  end
end
