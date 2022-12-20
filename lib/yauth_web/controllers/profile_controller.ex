defmodule YauthWeb.ProfileController do
  use YauthWeb, :controller
  alias YauthWeb.Authentication
  alias Yauth.Repo
  alias Yauth.Accounts.Post

  def show(conn, _params) do
    maybe_user = Guardian.Plug.current_resource(conn) |> Repo.preload(:posts)
    #render(conn, "secret.html", maybe_user: maybe_user)
    #all_data=Repo.all(Post, account_id: user.id)
    IO.inspect(maybe_user, label: "11111111111111111111")
    current_account = Authentication.get_current_account(conn)
    render(conn, :show, current_account: current_account, maybe_user: maybe_user)
  end
end
