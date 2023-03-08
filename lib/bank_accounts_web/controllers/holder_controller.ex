defmodule BankAccountsWeb.HolderController do
  use BankAccountsWeb, :controller

  alias BankAccounts.Holders
  alias BankAccounts.Holders.Holder

  action_fallback BankAccountsWeb.FallbackController

  def index(conn, _params) do
    holders = Holders.list_holders()
    render(conn, :index, holders: holders)
  end

  def create(conn, %{"holder" => holder_params}) do
    with {:ok, %Holder{} = holder} <- Holders.create_holder(holder_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/holders/#{holder}")
      |> render(:show, holder: holder)
    end
  end

  def show(conn, %{"id" => id}) do
    holder = Holders.get_holder!(id)
    render(conn, :show, holder: holder)
  end

  def update(conn, %{"id" => id, "holder" => holder_params}) do
    holder = Holders.get_holder!(id)

    with {:ok, %Holder{} = holder} <- Holders.update_holder(holder, holder_params) do
      render(conn, :show, holder: holder)
    end
  end

  def delete(conn, %{"id" => id}) do
    holder = Holders.get_holder!(id)

    with {:ok, %Holder{}} <- Holders.delete_holder(holder) do
      send_resp(conn, :no_content, "")
    end
  end
end
