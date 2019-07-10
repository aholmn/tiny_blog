defmodule TinyBlogWeb.TextController do
    use TinyBlogWeb, :controller

    import Ecto.Changeset 
    import Ecto.Query   
    
    alias TinyBlog.Repo
    
    
    def update(conn, %{"id" => id, "value" => value}) do
        Repo.get!(TinyBlog.Text, id)
        |> change(%{value: value})
        |> Repo.update()
        |> case do
            {:ok, _} ->
                conn
                |> put_flash(:info, "Title updated successfully.")
                |> redirect(to: Routes.admin_path(conn, :index))
            {:error, _} ->
                conn
                |> put_flash(:error, "Something went wrong.")
                |> redirect(to: Routes.admin_path(conn, :index))
        end
    
    end
end