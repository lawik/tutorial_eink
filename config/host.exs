use Mix.Config

# Note: We don't need the hal_module config anymore
config :eink, :viewport, %{
  name: :main_viewport,
  default_scene: {Eink.Scene.Main, nil},
  # Match these to your inky display
  size: {212, 104},
  opts: [scale: 1.0],
  drivers: [
    %{
      module: Scenic.Driver.Glfw
    }
  ]
}
