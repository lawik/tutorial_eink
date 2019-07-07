use Mix.Config

config :nerves, :firmware, rootfs_overlay: "rootfs_overlay"

config :shoehorn,
  init: [:nerves_runtime, :nerves_init_gadget],
  app: Mix.Project.config()[:app]

config :logger, backends: [RingLogger]

keys =
  [
    "./nerves.pub"
  ]
  |> Enum.filter(&File.exists?/1)

if keys == [],
  do:
    Mix.raise("""
    No SSH public keys found in ~/.ssh. An ssh authorized key is needed to
    log into the Nerves device and update firmware on it using ssh.
    See your project's config.exs for this error message.
    """)

config :nerves_firmware_ssh,
  authorized_keys: Enum.map(keys, &File.read!/1)

node_name = if Mix.env() != :prod, do: "eink"

config :nerves_init_gadget,
  ifname: "usb0",
  address_method: :dhcpd,
  mdns_domain: "nerves.local",
  node_name: node_name,
  node_host: :mdns_domain

config :eink, :viewport, %{
  name: :main_viewport,
  default_scene: {Eink.Scene.Main, nil},
  # Note: Match these to your inky display
  size: {212, 104},
  opts: [scale: 1.0],
  drivers: [
    %{
      module: ScenicDriverInky,
      opts: [
        # Note: Match these to your Inky display
        type: :phat,
        accent: :red,
        opts: %{
          border: :black
        }
      ]
    }
  ]
}
