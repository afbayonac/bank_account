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

  def cash_flow(%{flow: flow}) do
    %{data: %{ flow: flow }}
  end

  defp data(%Movement{} = movement) do
    %{
      id: movement.id,
      amount: movement.amount,
      from_id: movement.from_id,
      to_id: movement.to_id
    }
  end
end
