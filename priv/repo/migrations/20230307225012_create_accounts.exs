defmodule BankAccounts.Repo.Migrations.CreateAccounts do
  use Ecto.Migration

  def change do
    create table(:accounts, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :number, :string
      add :holder_id, references(:holders, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create index(:accounts, [:holder_id])
  end
end
