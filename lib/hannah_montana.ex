defmodule HannahMontana.Entry do
  def start(_type, _args) do
    token = System.get_env ("TG_TOKEN")
    {:ok, _} = Supervisor.start_link(
      [{Telegram.Poller, bots: [{HannahMontana.Handlers, token: token, max_bot_concurrency: 1_000}]}],
      strategy: :one_for_one
    )

    Process.sleep(:infinity)
  end
end
