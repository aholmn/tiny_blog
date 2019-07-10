defmodule TinyBlog.Repo do
    use Ecto.Repo,
      otp_app: :tiny_blog,
      adapter: Ecto.Adapters.Postgres
      
end
