defmodule Yauth.Accounts.Post do
  use Ecto.Schema
  import Ecto.Changeset
  alias Yauth.Repo

  schema "posts" do
    field :header, :string
    field :body, :string
    belongs_to :account, Yauth.Accounts.Account

    timestamps()
  end
  def changeset(struct, params) do
    struct
    |> cast(params, [:header, :body])
   end

end
