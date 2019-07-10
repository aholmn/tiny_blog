defmodule TinyBlogWeb.SessionController do
  use TinyBlogWeb, :controller
  
  alias TinyBlogWeb.Router.Helpers, as: Routes
  alias TinyBlog.Repo

  import TinyBlogWeb.AuthPlug

  plug :is_authenticated when action in [:new]


  def new(conn, _) do
    render conn, "new.html"
  end

  def create(conn, %{"session" => %{"username" => user, "password" =>
                                     pass}}) do

    case TinyBlog.Auth.login_by_username_and_pass(conn, user,
          pass, repo: Repo ) do

      {:ok, conn} ->
        conn
        |> put_flash(:info, "Welcome back!")
        |> redirect(to: Routes.admin_path(conn, :index))
      {:error, _reason, conn} ->
        conn
        |> put_flash(:error, "Invalid username/password combination")
        |> render("new.html")
    end
  end

  def delete(conn, _) do 
    conn
    |> TinyBlog.Auth.logout()
    |> redirect(to: Routes.page_path(conn, :index))
  end

end
