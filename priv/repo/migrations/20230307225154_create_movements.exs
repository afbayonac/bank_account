defmodule BankAccounts.Repo.Migrations.CreateMovements do
  use Ecto.Migration

  def change do
    create table(:movements, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :amount, :integer
      add :timestamp, :utc_datetime
      add :from, references(:accounts, on_delete: :nothing, type: :binary_id)
      add :to, references(:accounts, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create index(:movements, [:from])
    create index(:movements, [:to])
  end
end
