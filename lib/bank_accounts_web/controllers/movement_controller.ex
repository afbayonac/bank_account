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

  def show(conn, %{"id" => id}) do
    movement = Movements.get_movement!(id)
    render(conn, :show, movement: movement)
  end

  def update(conn, %{"id" => id, "movement" => movement_params}) do
    movement = Movements.get_movement!(id)

    with {:ok, %Movement{} = movement} <- Movements.update_movement(movement, movement_params) do
      render(conn, :show, movement: movement)
    end
  end

  def delete(conn, %{"id" => id}) do
    movement = Movements.get_movement!(id)

    with {:ok, %Movement{}} <- Movements.delete_movement(movement) do
      send_resp(conn, :no_content, "")
    end
  end
end
