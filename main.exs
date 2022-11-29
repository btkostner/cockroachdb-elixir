Mix.install([
  {:ecto_sql, "~> 3.9"},
  {:postgrex, ">= 0.0.0"}
], force: true)

defmodule Repo do
  use Ecto.Repo,
    otp_app: :my_app,
    adapter: Ecto.Adapters.Postgres
end

defmodule User do
  use Ecto.Schema

  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "users" do
    field :email, :string
  end

  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email])
  end
end

defmodule Main do
  def run() do
    # Delete everything that already exists
    Ecto.Adapters.SQL.query!(Repo, "DELETE FROM users;")

    # Create 10 records to test against
    for i <- 1..10 do
      %User{}
      |> User.changeset(%{"email" => "user-#{i}@example.com"})
      |> Repo.insert!()
    end

    # Search for same users but with an uppercased email address
    for i <- 1..10 do
      Repo.get_by!(User, email: "USER-#{i}@example.com")
    end
  end
end

Application.put_env(:my_app, Repo, [
  after_connect: {Postgrex, :query!, ["SET SESSION application_name = \"test-app\";", []]},
  migration_lock: false,
  url: "postgresql://root@database:26257/defaultdb"
])

Repo.start_link()
Ecto.Migrator.run(Repo, __DIR__ <> "/migrations", :up, all: true)

Main.run()
