defmodule BankAccountsWeb.MovementController do
  use BankAccountsWeb, :controller

  alias BankAccounts.Movements
  alias BankAccounts.Movements.Movement

  action_fallback BankAccountsWeb.FallbackController

  def index(conn, _params) do
    movements = Movements.list_movements()
    render(conn, :index, movements: movements)
  end

  def create(conn, %{"movement" => movement_params}) do
    with {:ok, %Movement{} = movement} <- Movements.create_movement(movement_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/movements/#{movement}")
      |> render(:show, movement: movement)
    end
  end

  def cash_flow(conn, _) do
    movements = Movements.list_movements()

    cash_outflows = movements
    |>Enum.filter(fn m -> m.to_id === nil end)
    |>Enum.reduce(0, fn m, acc -> acc + m.amount end)

    cash_inflows = movements
    |>Enum.filter(fn m -> m.from_id === nil end)
    |>Enum.reduce(0, fn m, acc -> acc + m.amount end)

    flow = %{
      cash_outflows: cash_outflows,
      cash_inflows: cash_inflows
    }

    render(conn, :cash_flow, flow: flow)
  end

  def show(conn, %{"id" => id}) do
    movement = Movements.get_movement!(id)
    render(conn, :show, movement: movement)
  end
end
