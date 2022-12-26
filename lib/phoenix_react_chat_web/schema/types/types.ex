defmodule PhoenixReactChatWeb.Schema.Types do
  use Absinthe.Schema.Notation

  import_types(PhoenixReactChatWeb.Schema.Types.UserType)
  import_types(PhoenixReactChatWeb.Schema.Types.RoomType)
  import_types(PhoenixReactChatWeb.Schema.Types.MessageType)
end
