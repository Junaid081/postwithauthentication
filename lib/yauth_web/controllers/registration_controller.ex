defmodule YauthWeb.RegistrationController do
  use YauthWeb, :controller
  plug Ueberauth
  alias Yauth.Accounts
  alias YauthWeb.Authentication

  def new(conn, _) do
    if Authentication.get_current_account(conn) do
      redirect(conn, to: Routes.profile_path(conn, :show))
    else
      render(
        conn,
        :new,
        changeset: Accounts.change_account(),
        action: Routes.registration_path(conn, :create)
      )

    end
  end

   def create(%{assigns: %{ueberauth_auth: auth_params}} = conn, _params) do
  #  IO.inspect(auth_params, label: "QQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQ")
  # IO.inspect(%Ueberauth.Auth{}, label: "wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww")
  #  IO.inspect(conn, label: "EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE")
    case Accounts.register(auth_params) do
      {:ok, account} ->
        conn
        |> Authentication.log_in(account)
        |> redirect(to: Routes.profile_path(conn, :show))

      {:error, changeset} ->
        render(conn, :new,
          changeset: changeset,
          action: Routes.registration_path(conn, :create)
        )
    end
  end

end
