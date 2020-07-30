defmodule Mysimplelist.Repo.Migrations.AddCompleteToListItem do
  use Ecto.Migration

  def change do
    alter table(:list_items) do
      add :complete, :boolean, default: false, null: false, after: :details
      add :completed_at, :utc_datetime_usec, null: true, after: :complete
    end
  end
end
