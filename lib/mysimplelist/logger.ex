defmodule Mysimplelist.Logger do
  require Logger

  def log(obj, operation \\ nil, level \\ :info, extra_metadata \\ [])

  def log(obj, operation, level, extra_metadata) when is_bitstring(obj) do
    Logger.log(level, fn -> "#{obj}" end, [operation: operation] ++ extra_metadata)

    obj
  end

  def log(obj, operation, level, extra_metadata) do
    Logger.log(level, fn -> inspect(obj) end, [operation: operation] ++ extra_metadata)

    obj
  end
end
