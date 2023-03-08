defmodule BankAccountsWeb.AccountController do
  use BankAccountsWeb, :controller

  alias BankAccounts.Accounts
  alias BankAccounts.Accounts.Account

  action_fallback BankAccountsWeb.FallbackController

  def index(conn, _params) do
    accounts = Accounts.list_accounts()
    render(conn, :index, accounts: accounts)
  end

  def create(conn, %{"account" => account_params}) do
    account = Accounts.create_account(account_params)
    conn
    |> put_status(:created)
    |> put_resp_header("location", ~p"/api/accounts/#{account}")
    |> render(:show, account: account)
  end

  def balance(conn, %{"id" => id}) do
    account = Accounts.get_account!(id)

    increments = account.increments
    |>Enum.reduce(0, fn i, acc -> acc + i.amount end)

    decrements = account.decrements
    |>Enum.reduce(0, fn d, acc -> acc + d.amount end)

    account = account
    |> Map.merge(%{
      balance: increments - decrements
    })

    render(conn, :balance, account: account)
  end

  def show(conn, %{"id" => id}) do
    account = Accounts.get_account!(id)
    render(conn, :show, account: account)
  end

  def update(conn, %{"id" => id, "account" => account_params}) do
    account = Accounts.get_account!(id)

    with {:ok, %Account{} = account} <- Accounts.update_account(account, account_params) do
      render(conn, :show, account: account)
    end
  end

  def delete(conn, %{"id" => id}) do
    account = Accounts.get_account!(id)

    with {:ok, %Account{}} <- Accounts.delete_account(account) do
      send_resp(conn, :no_content, "")
    end
  end
end
