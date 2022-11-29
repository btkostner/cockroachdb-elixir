defmodule UserMigration do
  use Ecto.Migration

  def up do
    create table(:users, primary_key: false) do
      add :id, :binary_id, primary_key: true

      add :email, :"TEXT COLLATE \"en-US-u-ks-level2\"", null: false
    end

    create unique_index(:users, [:email])
  end
end
