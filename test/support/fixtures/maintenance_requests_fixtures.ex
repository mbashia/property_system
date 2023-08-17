defmodule PropertySystem.Maintenance_requestsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `PropertySystem.Maintenance_requests` context.
  """

  @doc """
  Generate a maintenance_request.
  """
  def maintenance_request_fixture(attrs \\ %{}) do
    {:ok, maintenance_request} =
      attrs
      |> Enum.into(%{
        description: "some description",
        request_date: ~D[2023-08-16],
        status: "some status"
      })
      |> PropertySystem.Maintenance_requests.create_maintenance_request()

    maintenance_request
  end
end
