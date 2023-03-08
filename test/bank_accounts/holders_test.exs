defmodule BankAccounts.HoldersTest do
  use BankAccounts.DataCase

  alias BankAccounts.Holders

  describe "holders" do
    alias BankAccounts.Holders.Holder

    import BankAccounts.HoldersFixtures

    @invalid_attrs %{address: nil, birth: nil, name: nil, phone: nil}

    test "list_holders/0 returns all holders" do
      holder = holder_fixture()
      assert Holders.list_holders() == [holder]
    end

    test "get_holder!/1 returns the holder with given id" do
      holder = holder_fixture()
      assert Holders.get_holder!(holder.id) == holder
    end

    test "create_holder/1 with valid data creates a holder" do
      valid_attrs = %{address: "some address", birth: ~D[2023-03-06], name: "some name", phone: "some phone"}

      assert {:ok, %Holder{} = holder} = Holders.create_holder(valid_attrs)
      assert holder.address == "some address"
      assert holder.birth == ~D[2023-03-06]
      assert holder.name == "some name"
      assert holder.phone == "some phone"
    end

    test "create_holder/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Holders.create_holder(@invalid_attrs)
    end

    test "update_holder/2 with valid data updates the holder" do
      holder = holder_fixture()
      update_attrs = %{address: "some updated address", birth: ~D[2023-03-07], name: "some updated name", phone: "some updated phone"}

      assert {:ok, %Holder{} = holder} = Holders.update_holder(holder, update_attrs)
      assert holder.address == "some updated address"
      assert holder.birth == ~D[2023-03-07]
      assert holder.name == "some updated name"
      assert holder.phone == "some updated phone"
    end

    test "update_holder/2 with invalid data returns error changeset" do
      holder = holder_fixture()
      assert {:error, %Ecto.Changeset{}} = Holders.update_holder(holder, @invalid_attrs)
      assert holder == Holders.get_holder!(holder.id)
    end

    test "delete_holder/1 deletes the holder" do
      holder = holder_fixture()
      assert {:ok, %Holder{}} = Holders.delete_holder(holder)
      assert_raise Ecto.NoResultsError, fn -> Holders.get_holder!(holder.id) end
    end

    test "change_holder/1 returns a holder changeset" do
      holder = holder_fixture()
      assert %Ecto.Changeset{} = Holders.change_holder(holder)
    end
  end
end
