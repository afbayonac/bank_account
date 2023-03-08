defmodule BankAccounts.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `BankAccounts.Accounts` context.
  """

  @doc """
  Generate a account.
  """
  def account_fixture(attrs \\ %{}) do
    {:ok, account} =
      attrs
      |> Enum.into(%{
        number: "some number"
      })
      |> BankAccounts.Accounts.create_account()

    account
  end
end
