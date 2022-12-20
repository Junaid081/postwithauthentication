defmodule YauthWeb.PostsController do
  use YauthWeb, :controller
  alias Yauth.Posts
  import Ecto.Query, warn: false
  alias Yauth.Repo
  alias Yauth.Accounts.Account
  alias Yauth.Accounts.Post

  def index(conn, _params) do
    changeset = Posts.get_changeset_of_post()
    render(conn, :addnewpost, changeset: changeset, action: Routes.posts_path(conn, :create))
  end
  def create(conn, params) do
    header= params["posts"]
    header= header["header"]
    body= params["posts"]
    body= body["body"]
    user=Guardian.Plug.current_resource(conn)
    post1 = Ecto.build_assoc(user, :posts, %{header: header, body: body})
     Repo.insert!(post1)
    redirect(conn, to: Routes.profile_path(conn, :show))
  end

end
