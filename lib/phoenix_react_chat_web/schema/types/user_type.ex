defmodule PhoenixReactChatWeb.Schema.Types.UserType do

  use Absinthe.Schema.Notation

  object :user_type do
    field :id, :id
    field :name, :string
    field :email, :string
    field :username, :string
    field :inserted_at, :string
    field :rooms, list_of(:room_type)
  end

  input_object :registration_input_type do
    field :name, non_null(:string)
    field :email, non_null(:string)
    field :username, non_null(:string)
    field :password, non_null(:string)
  end
end
