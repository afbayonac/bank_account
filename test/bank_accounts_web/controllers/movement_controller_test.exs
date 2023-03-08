defmodule BankAccountsWeb.MovementControllerTest do
  use BankAccountsWeb.ConnCase

  import BankAccounts.MovementsFixtures

  alias BankAccounts.Movements.Movement

  @create_attrs %{
    amount: 42,
    timestamp: ~U[2023-03-06 22:51:00Z]
  }
  @update_attrs %{
    amount: 43,
    timestamp: ~U[2023-03-07 22:51:00Z]
  }
  @invalid_attrs %{amount: nil, timestamp: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all movements", %{conn: conn} do
      conn = get(conn, ~p"/api/movements")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create movement" do
    test "renders movement when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/movements", movement: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/movements/#{id}")

      assert %{
               "id" => ^id,
               "amount" => 42,
               "timestamp" => "2023-03-06T22:51:00Z"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/movements", movement: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update movement" do
    setup [:create_movement]

    test "renders movement when data is valid", %{conn: conn, movement: %Movement{id: id} = movement} do
      conn = put(conn, ~p"/api/movements/#{movement}", movement: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/movements/#{id}")

      assert %{
               "id" => ^id,
               "amount" => 43,
               "timestamp" => "2023-03-07T22:51:00Z"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, movement: movement} do
      conn = put(conn, ~p"/api/movements/#{movement}", movement: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete movement" do
    setup [:create_movement]

    test "deletes chosen movement", %{conn: conn, movement: movement} do
      conn = delete(conn, ~p"/api/movements/#{movement}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/movements/#{movement}")
      end
    end
  end

  defp create_movement(_) do
    movement = movement_fixture()
    %{movement: movement}
  end
end
