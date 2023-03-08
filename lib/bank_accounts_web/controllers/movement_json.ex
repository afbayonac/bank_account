defmodule BankAccountsWeb.MovementJSON do
  alias BankAccounts.Movements.Movement

  @doc """
  Renders a list of movements.
  """
  def index(%{movements: movements}) do
    %{data: for(movement <- movements, do: data(movement))}
  end

  @doc """
  Renders a single movement.
  """
  def show(%{movement: movement}) do
    %{data: data(movement)}
  end

  defp data(%Movement{} = movement) do
    %{
      id: movement.id,
      amount: movement.amount,
      timestamp: movement.timestamp
    }
  end
end
