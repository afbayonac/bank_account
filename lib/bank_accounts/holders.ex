defmodule BankAccounts.Holders do
  @moduledoc """
  The Holders context.
  """

  import Ecto.Query, warn: false
  alias BankAccounts.Repo

  alias BankAccounts.Holders.Holder

  @doc """
  Returns the list of holders.

  ## Examples

      iex> list_holders()
      [%Holder{}, ...]

  """
  def list_holders do
    Repo.all(Holder)
  end

  @doc """
  Gets a single holder.

  Raises `Ecto.NoResultsError` if the Holder does not exist.

  ## Examples

      iex> get_holder!(123)
      %Holder{}

      iex> get_holder!(456)
      ** (Ecto.NoResultsError)

  """
  def get_holder!(id), do: Repo.get!(Holder, id)

  @doc """
  Creates a holder.

  ## Examples

      iex> create_holder(%{field: value})
      {:ok, %Holder{}}

      iex> create_holder(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_holder(attrs \\ %{}) do
    %Holder{}
    |> Holder.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a holder.

  ## Examples

      iex> update_holder(holder, %{field: new_value})
      {:ok, %Holder{}}

      iex> update_holder(holder, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_holder(%Holder{} = holder, attrs) do
    holder
    |> Holder.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a holder.

  ## Examples

      iex> delete_holder(holder)
      {:ok, %Holder{}}

      iex> delete_holder(holder)
      {:error, %Ecto.Changeset{}}

  """
  def delete_holder(%Holder{} = holder) do
    Repo.delete(holder)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking holder changes.

  ## Examples

      iex> change_holder(holder)
      %Ecto.Changeset{data: %Holder{}}

  """
  def change_holder(%Holder{} = holder, attrs \\ %{}) do
    Holder.changeset(holder, attrs)
  end
end
