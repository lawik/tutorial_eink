defmodule Eink.Scene.Main do
  use Scenic.Scene
  alias Scenic.Graph

  import Scenic.Primitives

  @font :roboto
  @font_size 20

  def init(_, _) do
    graph =
      Graph.build(font_size: @font_size, font: @font, theme: :light)
      |> rectangle({212, 32}, fill: :red)
      |> rectangle({212, 64}, t: {0, 32}, fill: :white)
      |> rectangle({212, 8}, t: {0, 32 + 64}, fill: :red)
      |> do_aligned_text("HELLO", :white, @font_size + 6, 212, 20)
      |> do_aligned_text("my name is", :white, @font_size - 6, 212, 28)
      |> do_aligned_text("Inky", :black, @font_size + 32, 212, 80)

    state = %{
      graph: graph
    }

    {:ok, state, push: graph}
  end

  defp do_aligned_text(graph, text, fill, font_size, width, vpos) do
    text(graph, text,
      font_size: font_size,
      fill: fill,
      translate: {width / 2, vpos},
      text_align: :center
    )
  end
end
