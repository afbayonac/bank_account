defmodule BankAccountsWeb.HolderControllerTest do
  use BankAccountsWeb.ConnCase

  import BankAccounts.HoldersFixtures

  alias BankAccounts.Holders.Holder

  @create_attrs %{
    address: "some address",
    birth: ~D[2023-03-06],
    name: "some name",
    phone: "some phone"
  }
  @update_attrs %{
    address: "some updated address",
    birth: ~D[2023-03-07],
    name: "some updated name",
    phone: "some updated phone"
  }
  @invalid_attrs %{address: nil, birth: nil, name: nil, phone: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all holders", %{conn: conn} do
      conn = get(conn, ~p"/api/holders")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create holder" do
    test "renders holder when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/holders", holder: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/holders/#{id}")

      assert %{
               "id" => ^id,
               "address" => "some address",
               "birth" => "2023-03-06",
               "name" => "some name",
               "phone" => "some phone"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/holders", holder: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update holder" do
    setup [:create_holder]

    test "renders holder when data is valid", %{conn: conn, holder: %Holder{id: id} = holder} do
      conn = put(conn, ~p"/api/holders/#{holder}", holder: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/holders/#{id}")

      assert %{
               "id" => ^id,
               "address" => "some updated address",
               "birth" => "2023-03-07",
               "name" => "some updated name",
               "phone" => "some updated phone"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, holder: holder} do
      conn = put(conn, ~p"/api/holders/#{holder}", holder: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete holder" do
    setup [:create_holder]

    test "deletes chosen holder", %{conn: conn, holder: holder} do
      conn = delete(conn, ~p"/api/holders/#{holder}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/holders/#{holder}")
      end
    end
  end

  defp create_holder(_) do
    holder = holder_fixture()
    %{holder: holder}
  end
end
