defmodule PokemonWeb.PokemonController do
  use PokemonWeb, :controller

  def random(conn, %{"size" => size_param}) do
    size = parse_size(size_param)
    pokemons = Pokemon.Pokedex.random_pack(size)
    json(conn, %{pokemons: pokemons})
  end

  def random(conn, _params) do
    pokemons = Pokemon.Pokedex.random_pack()
    json(conn, %{pokemons: pokemons})
  end

  defp parse_size(size) do
    case Integer.parse(size) do
      {size, ""} when size > 0 and size <= 20 -> size
      _ -> 5
    end
  end
end
