defmodule TinyBlog.Text do
    use Ecto.Schema
    import Ecto.Changeset

    schema "texts" do
        field :keyword, :string
        field :value, :string
    end

end