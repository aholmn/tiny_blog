defmodule TinyBlogWeb.AdminController do
    use TinyBlogWeb , :controller

    import TinyBlogWeb.AuthPlug
    import Ecto.Query   
    alias TinyBlog.Entry
    alias TinyBlog.Repo

    plug :authenticate when action in [:index, :show]

    def index(conn, _params) do
        changeset = Entry.changeset(%Entry{}, %{})
        entries = Entry |> order_by(desc: :id) |> Repo.all()
        text = Repo.get_by(TinyBlog.Text, keyword: "header")
        render(conn, "index.html", changeset: changeset, entries: entries, text: text)
    end

    def create(conn, %{"entry" => entry_params}) do
        changeset = Entry.changeset(%Entry{}, Map.put(entry_params, "date", DateTime.utc_now()))
        {:ok, entry} = Repo.insert(changeset)
        conn
        |> put_flash(:info, "#{entry.title} created!")
        |> redirect(to: Routes.admin_path(conn, :index))
    end

end
