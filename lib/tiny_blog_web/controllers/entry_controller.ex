defmodule TinyBlogWeb.EntryController do
    use TinyBlogWeb, :controller
    
    import TinyBlogWeb.AuthPlug
    plug :authenticate when action in [:update, :edit, :delete]
    
    import Ecto.Query   
    alias TinyBlog.Entry
    alias TinyBlog.Repo

    def update(conn, %{"id" => id, "entry" => entry_params}) do
        entry = Repo.get!(TinyBlog.Entry, id)

        entry
        |> Entry.changeset(entry_params)
        |> Repo.update()
        |> case do
            {:ok, _} ->
                conn
                |> put_flash(:info, "Entry updated successfully.")
                |> redirect(to: Routes.admin_path(conn, :index))
            {:error, _} ->
                render(conn, "edit.html", id: id)
        end
    end

    def edit(conn, %{"id" => id}) do
        entry = Repo.get(TinyBlog.Entry, id)
        changeset = Entry.changeset(%Entry{}, %{title: entry.title, text: entry.text})
        
        render(conn, "edit.html", changeset: changeset, entry: entry)
    end

    def delete(conn, %{"id" => id}) do
        entry = Repo.get(TinyBlog.Entry, id)
        Repo.delete(entry)

        redirect(conn, to: Routes.admin_path(conn, :index))
    end
end