defmodule HannahMontana.Handlers do
  use Telegram.ChatBot

  @session_ttl 60 * 1_000

  @impl Telegram.ChatBot
  def init(_chat) do
      {:ok, @session_ttl}
  end

  # @impl Telegram.ChatBot
  # def handle_update(%{"message" => %{"text" => "hanna ", "chat" => %{"id" => chat_id}}}, token, _) do

  #   Telegram.Api.request(token, "pong",
  #     chat_id: chat_id,
  #     text: "It works with Elixir!"
  #   )

  #   {:ok, 0, @session_ttl}
  # end

  @impl Telegram.ChatBot
  def handle_update(%{
    "message" =>
      %{
          "message_id" => message_id,
          "sender_chat" => %{
            "type" => "channel"
          },
          "chat" => %{"id" => chat_id}
      }}, token, count_state) do
    Telegram.Api.request(token, "deleteMessage",
      chat_id: chat_id,
      message_id: message_id
    )
    {:ok, count_state, @session_ttl}
  end

  def handle_update(_update, _token, count_state) do
    {:ok, count_state, @session_ttl}
  end
end
