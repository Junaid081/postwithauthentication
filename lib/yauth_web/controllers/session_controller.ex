defmodule YauthWeb.SessionController do
  use YauthWeb, :controller
  alias Yauth.Accounts
  alias YauthWeb.Authentication

  def new(conn, _params) do
    if Authentication.get_current_account(conn) do
      redirect(conn, to: Routes.profile_path(conn, :show))
    else
      render(
        conn,
        :new,
        changeset: Accounts.change_account(),
        action: Routes.session_path(conn, :create)
      )
    end
  end

  def create(conn, %{"account" => %{"email" => email, "password" => password}}) do
    user = Accounts.get_by_email(conn,email,password)
    IO.inspect(user, label: "CONNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN")
    case user do
      nil ->
        conn
        |> put_flash(nil, "Incorrect email or password")
        |> new(%{})
        _ ->
          conn
          |> Authentication.log_in(user)
          |> redirect(to: Routes.profile_path(conn, :show))
    end
  end

  def delete(conn, _params) do
    conn
    |> Authentication.log_out()
    |> redirect(to: Routes.session_path(conn, :new))
  end

end
