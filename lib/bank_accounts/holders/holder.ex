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

  @spec changeset(
          {map, map}
          | %{
              :__struct__ => atom | %{:__changeset__ => map, optional(any) => any},
              optional(atom) => any
            },
          :invalid | %{optional(:__struct__) => none, optional(atom | binary) => any}
        ) :: Ecto.Changeset.t()
  @doc false
  def changeset(holder, attrs) do
    holder
    |> cast(attrs, [:name, :address, :birth, :phone])
    |> validate_required([:name, :address, :birth, :phone])
  end
end
