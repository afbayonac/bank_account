defmodule BankAccounts.Accounts.Account do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "accounts" do
    field :number, :string
    belongs_to :holder, BankAccounts.Holders.Holder
    has_many :movements_from, BankAccounts.Movements.Movement, foreign_key: :from_id
    has_many :movements_to, BankAccounts.Movements.Movement, foreign_key: :to_id
    timestamps()
  end

  @doc false
  def changeset(account, attrs) do
    account
    |> cast(attrs, [:number])
    |> validate_required([:number])
  end
end
