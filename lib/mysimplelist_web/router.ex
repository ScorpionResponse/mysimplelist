defmodule MysimplelistWeb.Router do
  use MysimplelistWeb, :router
  alias MysimplelistWeb.Plug.SetCurrentUser

  pipeline :auth do
    # plug(:fetch_session)
    plug(SetCurrentUser)
  end

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_live_flash)
    plug(:put_root_layout, {MysimplelistWeb.LayoutView, :root})
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
  end

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/", MysimplelistWeb do
    pipe_through(:browser)
    pipe_through(:auth)

    live("/", PageLive, :index)

    # Users
    live("/users", UserLive.Index, :index)
    live("/users/new", UserLive.Index, :new)
    live("/users/:id/edit", UserLive.Index, :edit)

    live("/users/:id", UserLive.Show, :show)
    live("/users/:id/show/edit", UserLive.Show, :edit)

    # Lists
    live("/lists", ListLive.Index, :index)
    live("/lists/new", ListLive.Index, :new)
    live("/lists/:id/edit", ListLive.Index, :edit)

    live("/lists/:id", ListLive.Show, :show)
    live("/lists/:id/show/edit", ListLive.Show, :edit)

    # List Items
    live("/list_items", ListItemLive.Index, :index)
    live("/list_items/new", ListItemLive.Index, :new)
    live("/list_items/:id/edit", ListItemLive.Index, :edit)

    live("/list_items/:id", ListItemLive.Show, :show)
    live("/list_items/:id/show/edit", ListItemLive.Show, :edit)
  end

  # Other scopes may use custom stacks.
  # scope "/api", MysimplelistWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through(:browser)
      live_dashboard("/dashboard", metrics: MysimplelistWeb.Telemetry)
    end
  end
end
