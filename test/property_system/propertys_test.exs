defmodule PropertySystem.PropertysTest do
  use PropertySystem.DataCase

  alias PropertySystem.Propertys

  describe "propertys" do
    alias PropertySystem.Propertys.Property

    import PropertySystem.PropertysFixtures

    @invalid_attrs %{address: nil, description: nil, name: nil, size: nil, status: nil, type: nil}

    test "list_propertys/0 returns all propertys" do
      property = property_fixture()
      assert Propertys.list_propertys() == [property]
    end

    test "get_property!/1 returns the property with given id" do
      property = property_fixture()
      assert Propertys.get_property!(property.id) == property
    end

    test "create_property/1 with valid data creates a property" do
      valid_attrs = %{
        address: "some address",
        description: "some description",
        name: "some name",
        size: 120.5,
        status: "some status",
        type: "some type"
      }

      assert {:ok, %Property{} = property} = Propertys.create_property(valid_attrs)
      assert property.address == "some address"
      assert property.description == "some description"
      assert property.name == "some name"
      assert property.size == 120.5
      assert property.status == "some status"
      assert property.type == "some type"
    end

    test "create_property/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Propertys.create_property(@invalid_attrs)
    end

    test "update_property/2 with valid data updates the property" do
      property = property_fixture()

      update_attrs = %{
        address: "some updated address",
        description: "some updated description",
        name: "some updated name",
        size: 456.7,
        status: "some updated status",
        type: "some updated type"
      }

      assert {:ok, %Property{} = property} = Propertys.update_property(property, update_attrs)
      assert property.address == "some updated address"
      assert property.description == "some updated description"
      assert property.name == "some updated name"
      assert property.size == 456.7
      assert property.status == "some updated status"
      assert property.type == "some updated type"
    end

    test "update_property/2 with invalid data returns error changeset" do
      property = property_fixture()
      assert {:error, %Ecto.Changeset{}} = Propertys.update_property(property, @invalid_attrs)
      assert property == Propertys.get_property!(property.id)
    end

    test "delete_property/1 deletes the property" do
      property = property_fixture()
      assert {:ok, %Property{}} = Propertys.delete_property(property)
      assert_raise Ecto.NoResultsError, fn -> Propertys.get_property!(property.id) end
    end

    test "change_property/1 returns a property changeset" do
      property = property_fixture()
      assert %Ecto.Changeset{} = Propertys.change_property(property)
    end
  end
end
