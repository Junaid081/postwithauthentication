defmodule Yauth.Accounts.Account do
  use Ecto.Schema
  import Ecto.Changeset
  alias Yauth.Repo

  schema "accounts" do
    field :email, :string
    field :password, :string
    field :username, :string
    has_many :posts, Yauth.Accounts.Post

    timestamps()
  end

  def changeset(struct, params) do
    IO.inspect(struct, label: "STRUCTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT")
    struct
    |> cast(params, [:username, :email, :password])
    |> validate_required([:email, :password])
    |> validate_confirmation(:password, required: true)
    |> unique_constraint(:email)
  end

  # defp put_encrypted_password(%{valid?: true, changes: %{password: pw}} = changeset) do
  #  put_change(changeset, :encrypted_password, Argon2.hash_pwd_salt(pw))
 # end

  # defp put_encrypted_password(changeset) do
   # changeset
  #  end
end
