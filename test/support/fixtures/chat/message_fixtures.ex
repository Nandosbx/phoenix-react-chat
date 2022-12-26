defmodule PhoenixReactChat.Chat.MessageFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `PhoenixReactChat.Chat.Message` context.
  """

  @doc """
  Generate a message.
  """
  def message_fixture(attrs \\ %{}) do
    {:ok, message} =
      attrs
      |> Enum.into(%{
        content: "some content"
      })
      |> PhoenixReactChat.Chat.Message.create_message()

    message
  end
end
