defmodule PhoenixReactChatWeb.Router do
  use PhoenixReactChatWeb, :router

  alias PhoenixReactChatWeb.AuthController
  alias PhoenixReactChatWeb.Plugs.PopulateAuth
  alias PhoenixReactChatWeb.Plugs.ProtectGraphql

  pipeline :api do
    plug :accepts, ["json"]
    plug :fetch_session
    plug PopulateAuth

  end

  pipeline :graphql do
    plug :accepts, ["json"]
    plug :fetch_session
    plug ProtectGraphql
  end

  scope "/api" do
    pipe_through :api
    post "/auth/register", AuthController, :register
    post "/auth/login", AuthController, :login
    delete "/auth/logout", AuthController, :logout
    get "/auth/getme", AuthController, :getme
  end

  scope "/api/graphql" do
    pipe_through :graphql

    get "/", Absinthe.Plug.GraphiQL,
      schema: PhoenixReactChatWeb.Schema,
      interface: :playground, socket: PhoenixReactChatWeb.UserSocket

    post "/", Absinthe.Plug, schema: PhoenixReactChatWeb.Schema
  end

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
      pipe_through [:fetch_session, :protect_from_forgery]
      live_dashboard "/dashboard", metrics: PhoenixReactChatWeb.Telemetry
    end
  end

  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
