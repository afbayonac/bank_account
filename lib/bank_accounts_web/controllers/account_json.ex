defmodule BankAccountsWeb.AccountJSON do
  alias BankAccounts.Accounts.Account

  @doc """
  Renders a list of accounts.
  """
  def index(%{accounts: accounts}) do
    %{data: for(account <- accounts, do: data(account))}
  end

  @doc """
  Renders a single account.
  """
  def show(%{account: account}) do
    %{data: data(account)}
  end

  def balance(%{account: account}) do
    IO.puts("render balance")
    drop_list = [:__meta__, :accounts, :__struct__, :create_at, :update_at]
    holder = account.holder |> Map.drop(drop_list)

    %{data: %{
        id: account.id,
        number: account.number,
        holder: holder,
        balance: account.balance
    }}
  end

  defp data(%Account{} = account) do
    drop_list = [:__meta__, :accounts, :__struct__, :create_at, :update_at]
    holder = account.holder |> Map.drop(drop_list)

    drop_list_movements = [:__meta__, :__struct__, :from, :to]

    increments = account.increments
    |> Enum.map(fn i -> i |> Map.drop(drop_list_movements) end)

    decrements = account.decrements
    |> Enum.map(fn i -> i |> Map.drop(drop_list_movements) end)

    %{
      id: account.id,
      number: account.number,
      holder: holder,
      increments: increments,
      decrements: decrements
    }
  end
end
