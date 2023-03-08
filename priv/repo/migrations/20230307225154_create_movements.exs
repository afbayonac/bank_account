defmodule BankAccounts.Repo.Migrations.CreateMovements do
  use Ecto.Migration

  def change do
    create table(:movements, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :amount, :integer
      add :from_id, references(:accounts, on_delete: :nothing, type: :binary_id)
      add :to_id, references(:accounts, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create index(:movements, [:from_id])
    create index(:movements, [:to_id])
  end
end
