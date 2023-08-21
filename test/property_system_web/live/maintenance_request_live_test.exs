defmodule PropertySystemWeb.Maintenance_requestLiveTest do
  use PropertySystemWeb.ConnCase

  import Phoenix.LiveViewTest
  import PropertySystem.Maintenance_requestsFixtures

  @create_attrs %{
    description: "some description",
    request_date: %{day: 16, month: 8, year: 2023},
    status: "some status"
  }
  @update_attrs %{
    description: "some updated description",
    request_date: %{day: 17, month: 8, year: 2023},
    status: "some updated status"
  }
  @invalid_attrs %{description: nil, request_date: %{day: 30, month: 2, year: 2023}, status: nil}

  defp create_maintenance_request(_) do
    maintenance_request = maintenance_request_fixture()
    %{maintenance_request: maintenance_request}
  end

  describe "Index" do
    setup [:create_maintenance_request]

    test "lists all maintenance_requests", %{conn: conn, maintenance_request: maintenance_request} do
      {:ok, _index_live, html} = live(conn, Routes.maintenance_request_index_path(conn, :index))

      assert html =~ "Listing Maintenance requests"
      assert html =~ maintenance_request.description
    end

    test "saves new maintenance_request", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.maintenance_request_index_path(conn, :index))

      assert index_live |> element("a", "New Maintenance request") |> render_click() =~
               "New Maintenance request"

      assert_patch(index_live, Routes.maintenance_request_index_path(conn, :new))

      assert index_live
             |> form("#maintenance_request-form", maintenance_request: @invalid_attrs)
             |> render_change() =~ "is invalid"

      {:ok, _, html} =
        index_live
        |> form("#maintenance_request-form", maintenance_request: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.maintenance_request_index_path(conn, :index))

      assert html =~ "Maintenance request created successfully"
      assert html =~ "some description"
    end

    test "updates maintenance_request in listing", %{
      conn: conn,
      maintenance_request: maintenance_request
    } do
      {:ok, index_live, _html} = live(conn, Routes.maintenance_request_index_path(conn, :index))

      assert index_live
             |> element("#maintenance_request-#{maintenance_request.id} a", "Edit")
             |> render_click() =~
               "Edit Maintenance request"

      assert_patch(
        index_live,
        Routes.maintenance_request_index_path(conn, :edit, maintenance_request)
      )

      assert index_live
             |> form("#maintenance_request-form", maintenance_request: @invalid_attrs)
             |> render_change() =~ "is invalid"

      {:ok, _, html} =
        index_live
        |> form("#maintenance_request-form", maintenance_request: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.maintenance_request_index_path(conn, :index))

      assert html =~ "Maintenance request updated successfully"
      assert html =~ "some updated description"
    end

    test "deletes maintenance_request in listing", %{
      conn: conn,
      maintenance_request: maintenance_request
    } do
      {:ok, index_live, _html} = live(conn, Routes.maintenance_request_index_path(conn, :index))

      assert index_live
             |> element("#maintenance_request-#{maintenance_request.id} a", "Delete")
             |> render_click()

      refute has_element?(index_live, "#maintenance_request-#{maintenance_request.id}")
    end
  end

  describe "Show" do
    setup [:create_maintenance_request]

    test "displays maintenance_request", %{conn: conn, maintenance_request: maintenance_request} do
      {:ok, _show_live, html} =
        live(conn, Routes.maintenance_request_show_path(conn, :show, maintenance_request))

      assert html =~ "Show Maintenance request"
      assert html =~ maintenance_request.description
    end

    test "updates maintenance_request within modal", %{
      conn: conn,
      maintenance_request: maintenance_request
    } do
      {:ok, show_live, _html} =
        live(conn, Routes.maintenance_request_show_path(conn, :show, maintenance_request))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Maintenance request"

      assert_patch(
        show_live,
        Routes.maintenance_request_show_path(conn, :edit, maintenance_request)
      )

      assert show_live
             |> form("#maintenance_request-form", maintenance_request: @invalid_attrs)
             |> render_change() =~ "is invalid"

      {:ok, _, html} =
        show_live
        |> form("#maintenance_request-form", maintenance_request: @update_attrs)
        |> render_submit()
        |> follow_redirect(
          conn,
          Routes.maintenance_request_show_path(conn, :show, maintenance_request)
        )

      assert html =~ "Maintenance request updated successfully"
      assert html =~ "some updated description"
    end
  end
end
