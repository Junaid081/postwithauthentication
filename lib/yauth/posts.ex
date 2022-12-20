defmodule Yauth.Posts do
  alias Yauth.Repo
  alias Yauth.Accounts.Post

  def get_changeset_of_post(post \\ %Post{}) do
    Post.changeset(post, %{})
  end


end
