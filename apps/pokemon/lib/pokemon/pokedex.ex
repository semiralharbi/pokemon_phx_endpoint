defmodule Pokemon.Pokedex do
  def random_pack(size \\ 5) do
    1..size
    |> Enum.map(fn _ -> %{name: Faker.Pokemon.name()} end)
    |> Enum.uniq_by(& &1)
    |> ensure_unique_list(size)
  end

  defp ensure_unique_list(list, size) when length(list) < size do
    list ++ random_pack(size - length(list))
  end

  defp ensure_unique_list(list, _size), do: list
end
