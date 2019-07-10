defmodule TinyBlogWeb.PageController do
  use TinyBlogWeb, :controller
  alias TinyBlog.Repo

  def index(conn, _params) do
    entries = Repo.all(TinyBlog.Entry)
    headline = Repo.all(TinyBlog.Text)

    render(conn, "index.html", entries: entries)
  end
end
