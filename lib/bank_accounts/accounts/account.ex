defmodule BankAccounts.Accounts.Account do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "accounts" do
    field :number, :string
    belongs_to :holder, BankAccounts.Holders.Holder
    has_many :increments, BankAccounts.Movements.Movement, foreign_key: :to_id
    has_many :decrements, BankAccounts.Movements.Movement, foreign_key: :from_id
    timestamps()
  end

  @doc false
  def changeset(account, attrs) do
    account
    |> cast(attrs, [:number, :holder_id])
    |> validate_required([:number, :holder_id])
    |> validate_format(:number,~r/[0-9]{3}-[0-9]{3}-[0-9]{3}/)
    |> unique_constraint(:number)
  end
end
