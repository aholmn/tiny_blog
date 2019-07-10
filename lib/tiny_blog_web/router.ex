defmodule TinyBlogWeb.Router do
  use TinyBlogWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug TinyBlog.Auth, repo: TinyBlog.Repo
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", TinyBlogWeb do
    pipe_through :browser

    get       "/", PageController, :index
    resources "/admin", AdminController, only: [:index, :create]
    post      "/texts/:id", TextController, :update
    post      "/entry/:id", EntryController, :update
    get       "/entry/:id", EntryController, :edit
    delete    "/entry/:id", EntryController, :delete
    resources "/sessions",  SessionController, only: [:new, :create, :delete]
  end

  # Other scopes may use custom stacks.
  # scope "/api", TinyBlogWeb do
  #   pipe_through :api
  # end
end
