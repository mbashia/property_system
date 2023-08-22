defmodule PropertySystemWeb.Router do
  use PropertySystemWeb, :router

  import PropertySystemWeb.UserAuth

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {PropertySystemWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :fetch_current_user
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", PropertySystemWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", PropertySystemWeb do
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
      pipe_through :browser
      live_dashboard "/dashboard", metrics: PropertySystemWeb.Telemetry
    end
  end

  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through :browser

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end

  ## Authentication routes

  scope "/", PropertySystemWeb do
    pipe_through [:browser, :redirect_if_user_is_authenticated]
    get "/users/register", UserRegistrationController, :new
    post "/users/register", UserRegistrationController, :create

    get "/users/log_in", UserSessionController, :new
    post "/users/log_in", UserSessionController, :create
    get "/users/reset_password", UserResetPasswordController, :new
    post "/users/reset_password", UserResetPasswordController, :create
    get "/users/reset_password/:token", UserResetPasswordController, :edit
    put "/users/reset_password/:token", UserResetPasswordController, :update
  end

  scope "/", PropertySystemWeb do
    pipe_through [:browser, :require_authenticated_user]
    live "/propertys", PropertyLive.Index, :index
    live "/propertys/new", PropertyLive.Index, :new
    live "/propertys/:id/edit", PropertyLive.Index, :edit
   
    live "/propertys/:id", PropertyLive.Show, :show
    live "/propertys/:id/add_room", PropertyLive.Show, :add_room

    live "/propertys/:id/show/edit", PropertyLive.Show, :edit
    live "/maintenance_requests", Maintenance_requestLive.Index, :index
    live "/maintenance_requests/new", Maintenance_requestLive.Index, :new
    live "/maintenance_requests/:id/edit", Maintenance_requestLive.Index, :edit

    live "/maintenance_requests/:id", Maintenance_requestLive.Show, :show
    live "/maintenance_requests/:id/show/edit", Maintenance_requestLive.Show, :edit
    live "/rooms", RoomLive.Index, :index
    live "/rooms/new", RoomLive.Index, :new
    live "/rooms/:id/edit", RoomLive.Index, :edit

    live "/rooms/:id", RoomLive.Show, :show
    live "/rooms/:id/show/edit", RoomLive.Show, :edit
    live "/rooms/:id/add_tenant", RoomLive.Show, :add_tenant

    get "/users/settings", UserSettingsController, :edit
    put "/users/settings", UserSettingsController, :update
    get "/users/settings/confirm_email/:token", UserSettingsController, :confirm_email
  end

  scope "/", PropertySystemWeb do
    pipe_through [:browser]

    delete "/users/log_out", UserSessionController, :delete
    get "/users/confirm", UserConfirmationController, :new
    post "/users/confirm", UserConfirmationController, :create
    get "/users/confirm/:token", UserConfirmationController, :edit
    post "/users/confirm/:token", UserConfirmationController, :update
  end
end
