defmodule BankAccounts.HoldersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `BankAccounts.Holders` context.
  """

  @doc """
  Generate a holder.
  """
  def holder_fixture(attrs \\ %{}) do
    {:ok, holder} =
      attrs
      |> Enum.into(%{
        address: "some address",
        birth: ~D[2023-03-06],
        name: "some name",
        phone: "some phone"
      })
      |> BankAccounts.Holders.create_holder()

    holder
  end
end
