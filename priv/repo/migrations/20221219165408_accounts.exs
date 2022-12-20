defmodule Yauth.Repo.Migrations.Accounts do
  use Ecto.Migration

  def change do
      create table(:accounts) do
        add :username, :string
        add :email, :string
        add :password, :string

        timestamps()
      end
      create unique_index(:accounts, [:email])
  end
end
