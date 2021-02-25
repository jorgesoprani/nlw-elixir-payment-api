defmodule PaymentApi do
  alias PaymentApi.Users.Create, as: UserCreate
  alias PaymentApi.Accounts.{Deposit,Withdraw}

  defdelegate create_user(params), to: UserCreate, as: :call

  defdelegate deposit(params), to: Deposit, as: :call

  defdelegate withdraw(params), to: Withdraw, as: :call
end
