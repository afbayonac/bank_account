defmodule BankAccounts.MovementsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `BankAccounts.Movements` context.
  """

  @doc """
  Generate a movement.
  """
  def movement_fixture(attrs \\ %{}) do
    {:ok, movement} =
      attrs
      |> Enum.into(%{
        amount: 42,
        timestamp: ~U[2023-03-06 22:51:00Z]
      })
      |> BankAccounts.Movements.create_movement()

    movement
  end
end
