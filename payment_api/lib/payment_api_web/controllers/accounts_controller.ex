defmodule PaymentApiWeb.UsersController do
  use PaymentApiWeb, :controller

  alias PaymentApi.User

  action_fallback PaymentApiWeb.FallbackController

  # def deposit(conn, params) do
  #   with {:ok, %Account{} = account} <- PaymentApi.deposit(params) do
  #     conn
  #     |> put_status(:ok)
  #     |> render("update.json", account: account)
  #   end
  # end
end
