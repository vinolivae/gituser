ExUnit.start()
Ecto.Adapters.SQL.Sandbox.mode(Gituser.Repo, :manual)

Mox.defmock(Gituser.Clients.GithubMock, for: Gituser.Clients.GithubBehaviour)
