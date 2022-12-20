defmodule Yauth.Accounts do
  alias Yauth.Repo
  alias Yauth.Accounts.Account
  alias Yauth.Accounts

  def register(%Ueberauth.Auth{} = params) do
#     IO.inspect(params, label: "mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm")
    %Account{}
    |> Account.changeset(extract_account_params(params))
    |> Yauth.Repo.insert()
  end

  defp extract_account_params(%{credentials: %{other: other}, extra: extra, info: info}) do
    info
    |> Map.from_struct()
    |> Map.merge(other)

    extra = Map.from_struct(extra)
    extra.raw_info["account"]
  end
  def change_account(account \\ %Account{}) do
    Account.changeset(account, %{})
  end
  def get_account(id) do
    Repo.get(Account, id)
  end
  def get_by_email(conn,email,password) do
    user=Repo.get_by(Account, email: email, password: password)
  end
end
