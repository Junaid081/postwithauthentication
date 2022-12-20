defmodule Yauth.Repo.Migrations.Posts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :header, :string
      add :body, :string
      add :account_id, references(:accounts, ondelete: :delete_all)

      timestamps()
    end
  end
end
