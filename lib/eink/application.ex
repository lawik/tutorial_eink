defmodule Eink.Application do
  @target Mix.target()

  use Application

  @spec start(any, any) :: :ignore | {:error, any} | {:ok, pid}
  def start(_type, _args) do
    opts = [strategy: :one_for_one, name: Eink.Supervisor]
    Supervisor.start_link(children(@target), opts)
  end

  def children(_target) do
    main_viewport_config = Application.get_env(:eink, :viewport)

    [
      {Eink.Display, []},
      {Scenic, viewports: [main_viewport_config]}
    ]
  end
end
