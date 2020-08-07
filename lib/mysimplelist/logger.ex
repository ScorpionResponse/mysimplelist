defmodule Mysimplelist.Logger do
  require Logger

  def log(obj, operation \\ nil, level \\ :info, extra_metadata \\ []) do
    Logger.log(level, fn -> inspect(obj) end, [operation: operation] ++ extra_metadata)

    obj
  end
end
