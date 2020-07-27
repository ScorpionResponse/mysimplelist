defmodule Mysimplelist.Repo do
  use Ecto.Repo,
    otp_app: :mysimplelist,
    adapter: Ecto.Adapters.Postgres
end
