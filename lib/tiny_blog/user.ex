defmodule TinyBlog.User do
    use Ecto.Schema
    import Ecto.Changeset

    schema "users" do
        field :username, :string
        field :password, :string

        timestamps()
    end

end