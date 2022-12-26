defmodule PhoenixReactChat.Repo do
  use Ecto.Repo,
    otp_app: :phoenix_react_chat,
    adapter: Ecto.Adapters.Postgres
end
