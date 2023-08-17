defmodule PropertySystemWeb.PropertyLiveTest do
  use PropertySystemWeb.ConnCase

  import Phoenix.LiveViewTest
  import PropertySystem.PropertysFixtures

  @create_attrs %{address: "some address", description: "some description", name: "some name", size: 120.5, status: "some status", type: "some type"}
  @update_attrs %{address: "some updated address", description: "some updated description", name: "some updated name", size: 456.7, status: "some updated status", type: "some updated type"}
  @invalid_attrs %{address: nil, description: nil, name: nil, size: nil, status: nil, type: nil}

  defp create_property(_) do
    property = property_fixture()
    %{property: property}
  end

  describe "Index" do
    setup [:create_property]

    test "lists all propertys", %{conn: conn, property: property} do
      {:ok, _index_live, html} = live(conn, Routes.property_index_path(conn, :index))

      assert html =~ "Listing Propertys"
      assert html =~ property.address
    end

    test "saves new property", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.property_index_path(conn, :index))

      assert index_live |> element("a", "New Property") |> render_click() =~
               "New Property"

      assert_patch(index_live, Routes.property_index_path(conn, :new))

      assert index_live
             |> form("#property-form", property: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#property-form", property: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.property_index_path(conn, :index))

      assert html =~ "Property created successfully"
      assert html =~ "some address"
    end

    test "updates property in listing", %{conn: conn, property: property} do
      {:ok, index_live, _html} = live(conn, Routes.property_index_path(conn, :index))

      assert index_live |> element("#property-#{property.id} a", "Edit") |> render_click() =~
               "Edit Property"

      assert_patch(index_live, Routes.property_index_path(conn, :edit, property))

      assert index_live
             |> form("#property-form", property: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#property-form", property: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.property_index_path(conn, :index))

      assert html =~ "Property updated successfully"
      assert html =~ "some updated address"
    end

    test "deletes property in listing", %{conn: conn, property: property} do
      {:ok, index_live, _html} = live(conn, Routes.property_index_path(conn, :index))

      assert index_live |> element("#property-#{property.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#property-#{property.id}")
    end
  end

  describe "Show" do
    setup [:create_property]

    test "displays property", %{conn: conn, property: property} do
      {:ok, _show_live, html} = live(conn, Routes.property_show_path(conn, :show, property))

      assert html =~ "Show Property"
      assert html =~ property.address
    end

    test "updates property within modal", %{conn: conn, property: property} do
      {:ok, show_live, _html} = live(conn, Routes.property_show_path(conn, :show, property))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Property"

      assert_patch(show_live, Routes.property_show_path(conn, :edit, property))

      assert show_live
             |> form("#property-form", property: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#property-form", property: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.property_show_path(conn, :show, property))

      assert html =~ "Property updated successfully"
      assert html =~ "some updated address"
    end
  end
end
