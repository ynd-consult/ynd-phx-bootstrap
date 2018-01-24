ExUnit.configure formatters: [JUnitFormatter, ExUnit.CLIFormatter]
ExUnit.start()

Ecto.Adapters.SQL.Sandbox.mode(YndPhxBootstrap.Repo, :manual)

