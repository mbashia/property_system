defmodule PropertySystem.Maintenance_requestsTest do
  use PropertySystem.DataCase

  alias PropertySystem.Maintenance_requests

  describe "maintenance_requests" do
    alias PropertySystem.Maintenance_requests.Maintenance_request

    import PropertySystem.Maintenance_requestsFixtures

    @invalid_attrs %{description: nil, request_date: nil, status: nil}

    test "list_maintenance_requests/0 returns all maintenance_requests" do
      maintenance_request = maintenance_request_fixture()
      assert Maintenance_requests.list_maintenance_requests() == [maintenance_request]
    end

    test "get_maintenance_request!/1 returns the maintenance_request with given id" do
      maintenance_request = maintenance_request_fixture()

      assert Maintenance_requests.get_maintenance_request!(maintenance_request.id) ==
               maintenance_request
    end

    test "create_maintenance_request/1 with valid data creates a maintenance_request" do
      valid_attrs = %{
        description: "some description",
        request_date: ~D[2023-08-16],
        status: "some status"
      }

      assert {:ok, %Maintenance_request{} = maintenance_request} =
               Maintenance_requests.create_maintenance_request(valid_attrs)

      assert maintenance_request.description == "some description"
      assert maintenance_request.request_date == ~D[2023-08-16]
      assert maintenance_request.status == "some status"
    end

    test "create_maintenance_request/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} =
               Maintenance_requests.create_maintenance_request(@invalid_attrs)
    end

    test "update_maintenance_request/2 with valid data updates the maintenance_request" do
      maintenance_request = maintenance_request_fixture()

      update_attrs = %{
        description: "some updated description",
        request_date: ~D[2023-08-17],
        status: "some updated status"
      }

      assert {:ok, %Maintenance_request{} = maintenance_request} =
               Maintenance_requests.update_maintenance_request(maintenance_request, update_attrs)

      assert maintenance_request.description == "some updated description"
      assert maintenance_request.request_date == ~D[2023-08-17]
      assert maintenance_request.status == "some updated status"
    end

    test "update_maintenance_request/2 with invalid data returns error changeset" do
      maintenance_request = maintenance_request_fixture()

      assert {:error, %Ecto.Changeset{}} =
               Maintenance_requests.update_maintenance_request(
                 maintenance_request,
                 @invalid_attrs
               )

      assert maintenance_request ==
               Maintenance_requests.get_maintenance_request!(maintenance_request.id)
    end

    test "delete_maintenance_request/1 deletes the maintenance_request" do
      maintenance_request = maintenance_request_fixture()

      assert {:ok, %Maintenance_request{}} =
               Maintenance_requests.delete_maintenance_request(maintenance_request)

      assert_raise Ecto.NoResultsError, fn ->
        Maintenance_requests.get_maintenance_request!(maintenance_request.id)
      end
    end

    test "change_maintenance_request/1 returns a maintenance_request changeset" do
      maintenance_request = maintenance_request_fixture()

      assert %Ecto.Changeset{} =
               Maintenance_requests.change_maintenance_request(maintenance_request)
    end
  end
end
