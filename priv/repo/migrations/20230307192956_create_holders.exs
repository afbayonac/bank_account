defmodule BankAccounts.Repo.Migrations.CreateHolders do
  use Ecto.Migration

  def change do
    create table(:holders, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :address, :string
      add :birth, :date
      add :phone, :string

      timestamps()
    end
  end
end
