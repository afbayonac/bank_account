defmodule BankAccounts.Repo do
  use Ecto.Repo,
    otp_app: :bank_accounts,
    adapter: Ecto.Adapters.Postgres
end
