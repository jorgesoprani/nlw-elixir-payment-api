defmodule PaymentApi.Accounts.Withdraw do
  alias Ecto.Multi

  alias PaymentApi.{Account,Repo}

  def call(%{"id" => id, "value" => value}) do
    Multi.new()
    |> Multi.run(:get_account, fn repo, _changes -> get_account(repo, id) end)
    |> Multi.run(:update_balance, fn repo, %{get_account: account} -> update_balance(repo, account, value) end)
    |> run_transaction()
  end

  defp get_account(repo, id) do
    case repo.get(Account, id) do
      nil -> {:error, "Account not found!"}
      account -> {:ok, account}
    end
  end

  defp update_balance(repo, account, value) do
    account
    |> sum_values(value)
    |> update_account(repo, account)
  end

  defp sum_values(%Account{balance: balance}, value) do
    value
    |> Decimal.cast()
    |> handle_cast(balance)
  end

  defp update_account({:error, _reason} = error, _repo, _account), do: error

  defp update_account(value, repo, account) do
    account
    |> Account.changeset(%{balance: value})
    |> repo.update()

  end

  defp handle_cast({:ok, value}, balance), do: Decimal.sub(balance,value)
  defp handle_cast(:error, _balance), do: {:error, "Invalid deposit value!"}

  defp run_transaction(multi) do
    case Repo.transaction(multi) do
      {:error, _operation, reason, _changes} -> {:error, reason}
      {:ok, %{update_balance: account}} -> {:ok, account}
    end
  end
end
