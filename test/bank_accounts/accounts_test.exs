defmodule BankAccounts.AccountsTest do
  use BankAccounts.DataCase

  alias BankAccounts.Accounts

  describe "accounts" do
    alias BankAccounts.Accounts.Account

    import BankAccounts.AccountsFixtures

    @invalid_attrs %{birth: nil, holder: nil, number: nil, phone: nil}

    test "list_accounts/0 returns all accounts" do
      account = account_fixture()
      assert Accounts.list_accounts() == [account]
    end

    test "get_account!/1 returns the account with given id" do
      account = account_fixture()
      assert Accounts.get_account!(account.id) == account
    end

    test "create_account/1 with valid data creates a account" do
      valid_attrs = %{birth: ~D[2023-03-06], holder: "some holder", number: "some number", phone: "some phone"}

      assert {:ok, %Account{} = account} = Accounts.create_account(valid_attrs)
      assert account.birth == ~D[2023-03-06]
      assert account.holder == "some holder"
      assert account.number == "some number"
      assert account.phone == "some phone"
    end

    test "create_account/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_account(@invalid_attrs)
    end

    test "update_account/2 with valid data updates the account" do
      account = account_fixture()
      update_attrs = %{birth: ~D[2023-03-07], holder: "some updated holder", number: "some updated number", phone: "some updated phone"}

      assert {:ok, %Account{} = account} = Accounts.update_account(account, update_attrs)
      assert account.birth == ~D[2023-03-07]
      assert account.holder == "some updated holder"
      assert account.number == "some updated number"
      assert account.phone == "some updated phone"
    end

    test "update_account/2 with invalid data returns error changeset" do
      account = account_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_account(account, @invalid_attrs)
      assert account == Accounts.get_account!(account.id)
    end

    test "delete_account/1 deletes the account" do
      account = account_fixture()
      assert {:ok, %Account{}} = Accounts.delete_account(account)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_account!(account.id) end
    end

    test "change_account/1 returns a account changeset" do
      account = account_fixture()
      assert %Ecto.Changeset{} = Accounts.change_account(account)
    end
  end

  describe "accounts" do
    alias BankAccounts.Accounts.Account

    import BankAccounts.AccountsFixtures

    @invalid_attrs %{number: nil}

    test "list_accounts/0 returns all accounts" do
      account = account_fixture()
      assert Accounts.list_accounts() == [account]
    end

    test "get_account!/1 returns the account with given id" do
      account = account_fixture()
      assert Accounts.get_account!(account.id) == account
    end

    test "create_account/1 with valid data creates a account" do
      valid_attrs = %{number: "some number"}

      assert {:ok, %Account{} = account} = Accounts.create_account(valid_attrs)
      assert account.number == "some number"
    end

    test "create_account/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_account(@invalid_attrs)
    end

    test "update_account/2 with valid data updates the account" do
      account = account_fixture()
      update_attrs = %{number: "some updated number"}

      assert {:ok, %Account{} = account} = Accounts.update_account(account, update_attrs)
      assert account.number == "some updated number"
    end

    test "update_account/2 with invalid data returns error changeset" do
      account = account_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_account(account, @invalid_attrs)
      assert account == Accounts.get_account!(account.id)
    end

    test "delete_account/1 deletes the account" do
      account = account_fixture()
      assert {:ok, %Account{}} = Accounts.delete_account(account)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_account!(account.id) end
    end

    test "change_account/1 returns a account changeset" do
      account = account_fixture()
      assert %Ecto.Changeset{} = Accounts.change_account(account)
    end
  end
end
