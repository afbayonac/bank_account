defmodule BankAccounts.Movements.Movement do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "movements" do
    field :amount, :integer
    belongs_to :from, BankAccounts.Holders.Holder
    belongs_to :to, BankAccounts.Holders.Holder

    timestamps()
  end

  @doc false
  def changeset(movement, attrs) do
    movement
    |> cast(attrs, [:amount, :from_id, :to_id])
    |> validate_required([:amount, :from_id, :to_id])
  end
end
