defmodule HannahMontana.Handlers do
  use Telegram.ChatBot

  @session_ttl 60 * 1_000

  @impl Telegram.ChatBot
  def init(_chat) do
      {:ok, @session_ttl}
  end

  @impl Telegram.ChatBot
  def handle_update(%{
    "message" =>
      %{
          "message_id" => message_id,
          "sender_chat" => %{
            "id" => sender_chat_id,
            "type" => "channel"
          },
          "chat" => %{"id" => chat_id}
      }}, token, count_state) do
    {:ok, %{"linked_chat_id" => linked_chat_id}} =
      Telegram.Api.request(token, "getChat",
        chat_id: chat_id
      )
    if linked_chat_id !== sender_chat_id do
      Telegram.Api.request(token, "deleteMessage",
        chat_id: chat_id,
        message_id: message_id
      )
    end
    {:ok, count_state, @session_ttl}
  end

  def handle_update(_update, _token, count_state) do
    {:ok, count_state, @session_ttl}
  end
end
