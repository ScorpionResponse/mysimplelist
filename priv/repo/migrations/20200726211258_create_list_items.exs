defmodule Mysimplelist.Repo.Migrations.CreateListItems do
  use Ecto.Migration

  def change do
    create table(:list_items) do
      add :title, :string
      add :details, :text
      add :list_id, references(:lists, on_delete: :nothing)

      timestamps()
    end

    create index(:list_items, [:list_id])
  end
end
