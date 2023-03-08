defmodule BankAccounts.MovementsTest do
  use BankAccounts.DataCase

  alias BankAccounts.Movements

  describe "movements" do
    alias BankAccounts.Movements.Movement

    import BankAccounts.MovementsFixtures

    @invalid_attrs %{amount: nil, timestamp: nil}

    test "list_movements/0 returns all movements" do
      movement = movement_fixture()
      assert Movements.list_movements() == [movement]
    end

    test "get_movement!/1 returns the movement with given id" do
      movement = movement_fixture()
      assert Movements.get_movement!(movement.id) == movement
    end

    test "create_movement/1 with valid data creates a movement" do
      valid_attrs = %{amount: 42, timestamp: ~U[2023-03-06 22:51:00Z]}

      assert {:ok, %Movement{} = movement} = Movements.create_movement(valid_attrs)
      assert movement.amount == 42
      assert movement.timestamp == ~U[2023-03-06 22:51:00Z]
    end

    test "create_movement/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Movements.create_movement(@invalid_attrs)
    end

    test "update_movement/2 with valid data updates the movement" do
      movement = movement_fixture()
      update_attrs = %{amount: 43, timestamp: ~U[2023-03-07 22:51:00Z]}

      assert {:ok, %Movement{} = movement} = Movements.update_movement(movement, update_attrs)
      assert movement.amount == 43
      assert movement.timestamp == ~U[2023-03-07 22:51:00Z]
    end

    test "update_movement/2 with invalid data returns error changeset" do
      movement = movement_fixture()
      assert {:error, %Ecto.Changeset{}} = Movements.update_movement(movement, @invalid_attrs)
      assert movement == Movements.get_movement!(movement.id)
    end

    test "delete_movement/1 deletes the movement" do
      movement = movement_fixture()
      assert {:ok, %Movement{}} = Movements.delete_movement(movement)
      assert_raise Ecto.NoResultsError, fn -> Movements.get_movement!(movement.id) end
    end

    test "change_movement/1 returns a movement changeset" do
      movement = movement_fixture()
      assert %Ecto.Changeset{} = Movements.change_movement(movement)
    end
  end
end
