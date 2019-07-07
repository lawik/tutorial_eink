use Mix.Config

targeting =
  case Mix.target() do
    :host -> :host
    _ -> :device
  end

import_config "#{targeting}.exs"
