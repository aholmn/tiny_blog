defmodule TinyBlogWeb.LayoutView do
  use TinyBlogWeb, :view
  alias TinyBlog.Repo

  def title do
    text = Repo.get_by(TinyBlog.Text, keyword: "header")
    text.value
  end
end
