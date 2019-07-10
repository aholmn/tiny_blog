defmodule TinyBlogWeb.AuthPlug do
    
    import Plug.Conn
    import Phoenix.Controller
    
    alias TinyBlogWeb.Router.Helpers, as: Routes

    def authenticate(conn, _opts) do
        if conn.assigns.current_user do
            conn
        else
            conn
            |> put_flash(:error, "You must be logged in to access that page")
            |> redirect(to: Routes.session_path(conn, :new))
            |> halt()
        end
    end

    def is_authenticated(conn, _opts) do
        if conn.assigns.current_user do
            redirect(conn, to: Routes.admin_path(conn, :index))
        else
            conn
        end
    end

end
