defmodule PhoenixReactChatWeb.Schema.Resolvers.MessageResolver do
  alias PhoenixReactChat.Chat

  alias PhoenixReactChat.Chat.Room
  alias PhoenixReactChat.Chat.Message
  alias PhoenixReactChatWeb.Utils
  alias PhoenixReactChatWeb.Constants

  def delete_message(_,%{input: input}, %{context: context}) do
    case Message.delete_message_by_id(input.message_id, context.current_user.id) do
      {1, _} ->
        {:ok, true}
        {0, _} ->
          {:error, Constants.not_found()}
          _ -> {:error, Constants.internal_server_error()}
   end
  end

  def get_all_messages(_,%{input: input},%{context: _context}) do
    messages = Message.list_messages(input.room_id)
    {:ok, messages}
  end

  def create_message(_, %{input: input}, %{context: context}) do

    case Chat.get_room(input.room_id) do
      %Room{} ->

    input_with_ids = Map.merge(input, %{user_id: context.current_user.id, room_id: input.room_id})

    case Message.create_message(input_with_ids) do
      {:ok, _message} -> {:ok, true}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:error, Utils.format_changeset_errors(changeset)}

        _ -> {:error, Constants.internal_server_error()}
      end

      _ -> {:error, Constants.not_found()}
    end
  end
end
