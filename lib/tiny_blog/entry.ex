  defmodule TinyBlog.Entry do
    use Ecto.Schema
    import Ecto.Changeset

    schema "entries" do
      field :date, :date
      field :text, :string
      field :title, :string

      timestamps()
    end

    @doc false
    def changeset(entry, attrs) do
      entry
      |> cast(attrs, [:title, :text, :date])
      |> validate_required([:title, :text, :date])
    end
  end
