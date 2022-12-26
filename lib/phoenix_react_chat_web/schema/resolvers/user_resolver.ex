defmodule PhoenixReactChatWeb.Schema.Resolvers.UserResolver do
  alias PhoenixReactChat.Auth
  alias PhoenixReactChatWeb.Utils
  alias PhoenixReactChatWeb.Constants


  def get_all_users(_,_,%{context: _context}) do
    users = Auth.list_users()
    {:ok, users}
  end

  def get_me(_,_, %{context: %{current_user: current_user}}) do
    {:ok, current_user}
  end

  def register_user(_, %{input: input}, _) do
    case Auth.create_user(input) do
      {:ok, _} ->
        {:ok, true}

      {:error, %Ecto.Changeset{}= changeset} ->
        errors = Utils.format_changeset_errors(changeset)
        {:error, errors}

      {_, _} ->
        {:error, Constants.internal_server_error()}
    end
  end
end
