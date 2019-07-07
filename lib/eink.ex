defmodule Eink.Display do
  use GenServer

  def start_link(opts) do
    GenServer.start_link(__MODULE__, nil, opts)
  end

  @impl true
  def init(_) do
    {:ok, pid} =
      Inky.start_link(:phat, :red, %{
        hal_mod: Application.get_env(:inky, :hal_module, Inky.RpiHAL)
      })

    Inky.set_pixels(pid, fn x, y, _width, _height, _current ->
      # Delightful checkerboard
      x_odd = rem(x, 2) != 0
      y_odd = rem(y, 2) != 0

      case x_odd do
        true ->
          case y_odd do
            true -> :black
            false -> :accent
          end

        false ->
          case y_odd do
            true -> :accent
            false -> :white
          end
      end
    end)

    {:ok, nil}
  end
end
