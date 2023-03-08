defmodule BankAccounts.Movements.Movement do
  use Ecto.Schema
  import Ecto.Changeset
  alias BankAccounts.Accounts

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
    |> validate_required([:amount])
    |> validate_number(:amount, greater_than: 0, less_than: 1.0e9)
    |> validate_from_to()
    |> validate_amount
  end

  def is_available_mount?(id, amount) do
    account = Accounts.get_account!(id)
    increments = account.increments
    |>Enum.reduce(0, fn i, acc -> acc + i.amount end)

    decrements = account.decrements
    |>Enum.reduce(0, fn d, acc -> acc + d.amount end)

    if (increments - decrements) >= amount, do: true, else: false
  end

  def validate_amount(changeset) do
    amount = changeset |> get_field(:amount)
    case changeset |> get_field(:from_id) do
      nil -> changeset
      id -> if is_available_mount?(id, amount),
        do: changeset,
        else: changeset |> add_error(:amount, "insufficient balance")
    end
  end



  def validate_from_to(changeset) do
    from_id = changeset |> get_field(:from_id)
    to_id = changeset |> get_field(:to_id)

    if from_id === nil and to_id === nil do
      changeset
      |> add_error(:from_id, "at least one reference must be present")
      |> add_error(:to_id, "at least one reference must be present")
    else
      changeset
    end
  end
end
