defmodule BankAccounts.Holders.Holder do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "holders" do
    field :address, :string
    field :birth, :date
    field :name, :string
    field :phone, :string
    has_many :accounts, BankAccounts.Accounts.Account
    timestamps()
  end

  @doc false
  def changeset(holder, attrs) do
    holder
    |> cast(attrs, [:name, :address, :birth, :phone])
    |> validate_required([:name, :address, :birth, :phone])
    |> validate_length(:address, min: 4, max: 100)
    |> validate_length(:phone, is: 10)
    |> validate_length(:name, min: 4, max: 100)
  end
end
