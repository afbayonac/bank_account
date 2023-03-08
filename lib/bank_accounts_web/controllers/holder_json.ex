defmodule BankAccountsWeb.HolderJSON do
  alias BankAccounts.Holders.Holder

  @doc """
  Renders a list of holders.
  """
  def index(%{holders: holders}) do
    %{data: for(holder <- holders, do: data(holder))}
  end

  @doc """
  Renders a single holder.
  """
  def show(%{holder: holder}) do
    %{data: data(holder)}
  end

  defp data(%Holder{} = holder) do
    %{
      id: holder.id,
      name: holder.name,
      address: holder.address,
      birth: holder.birth,
      phone: holder.phone
    }
  end
end
