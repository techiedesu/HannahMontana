defmodule HannahMontana.Entry do
  def start(_type, _args) do
    token = "5520808093:AAGNWUuJd3ePYDAeQmb2WBzPeRA4ZZDebTc"
    {:ok, _} = Supervisor.start_link(
      [{Telegram.Poller, bots: [{HannahMontana.Handlers, token: token, max_bot_concurrency: 1_000}]}],
      strategy: :one_for_one
    )

    Process.sleep(:infinity)
  end
end
