defmodule BankAccountsWeb.Router do
  use BankAccountsWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api" do
    pipe_through :api
    resources "/holders", BankAccountsWeb.HolderController, only: [:index, :show, :create, :update]
    resources "/accounts", BankAccountsWeb.AccountController, only: [:index, :show, :create]
    resources "/movements", BankAccountsWeb.MovementController, only: [:index, :show, :create]
  end

end
