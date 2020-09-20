defmodule Mysimplelist.Logger do
  require Logger

  defp determine_level(operation) do
    # TODO: This could be defined in the database to allow otf configuration
    case String.split(Atom.to_string(operation), "_") do
      ["User", "Defaulted"] -> :warn
      ["User" | _] -> :info
      ["List" | _] -> :info
      ["ListItem" | _] -> :info
      _ -> :info
    end
  end

  def log(obj, operation \\ nil, override_level \\ nil, extra_metadata \\ [])

  def log(obj, operation, override_level, extra_metadata) when is_bitstring(obj) do
    level = override_level || determine_level(operation)
    Logger.log(level, fn -> "#{obj}" end, [operation: operation] ++ extra_metadata)

    obj
  end

  def log(obj, operation, override_level, extra_metadata) do
    level = override_level || determine_level(operation)
    Logger.log(level, fn -> inspect(obj) end, [operation: operation] ++ extra_metadata)

    obj
  end
end
