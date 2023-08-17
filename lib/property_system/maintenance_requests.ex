defmodule PropertySystem.Maintenance_requests do
  @moduledoc """
  The Maintenance_requests context.
  """

  import Ecto.Query, warn: false
  alias PropertySystem.Repo

  alias PropertySystem.Maintenance_requests.Maintenance_request

  @doc """
  Returns the list of maintenance_requests.

  ## Examples

      iex> list_maintenance_requests()
      [%Maintenance_request{}, ...]

  """
  def list_maintenance_requests do
    Repo.all(Maintenance_request)
  end

  @doc """
  Gets a single maintenance_request.

  Raises `Ecto.NoResultsError` if the Maintenance request does not exist.

  ## Examples

      iex> get_maintenance_request!(123)
      %Maintenance_request{}

      iex> get_maintenance_request!(456)
      ** (Ecto.NoResultsError)

  """
  def get_maintenance_request!(id), do: Repo.get!(Maintenance_request, id)

  @doc """
  Creates a maintenance_request.

  ## Examples

      iex> create_maintenance_request(%{field: value})
      {:ok, %Maintenance_request{}}

      iex> create_maintenance_request(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_maintenance_request(attrs \\ %{}) do
    %Maintenance_request{}
    |> Maintenance_request.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a maintenance_request.

  ## Examples

      iex> update_maintenance_request(maintenance_request, %{field: new_value})
      {:ok, %Maintenance_request{}}

      iex> update_maintenance_request(maintenance_request, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_maintenance_request(%Maintenance_request{} = maintenance_request, attrs) do
    maintenance_request
    |> Maintenance_request.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a maintenance_request.

  ## Examples

      iex> delete_maintenance_request(maintenance_request)
      {:ok, %Maintenance_request{}}

      iex> delete_maintenance_request(maintenance_request)
      {:error, %Ecto.Changeset{}}

  """
  def delete_maintenance_request(%Maintenance_request{} = maintenance_request) do
    Repo.delete(maintenance_request)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking maintenance_request changes.

  ## Examples

      iex> change_maintenance_request(maintenance_request)
      %Ecto.Changeset{data: %Maintenance_request{}}

  """
  def change_maintenance_request(%Maintenance_request{} = maintenance_request, attrs \\ %{}) do
    Maintenance_request.changeset(maintenance_request, attrs)
  end
end
