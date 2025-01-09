defmodule LiveFlipDemoWeb.HomeLive do
  use LiveFlipDemoWeb, :live_view

  import LiveFlip

  def mount(_params, _session, socket) do
    shapes =
      if connected?(socket) do
        schedule_update()

        Stream.repeatedly(fn ->
          Map.merge(
            %{
              type: Enum.random([:square, :circle]),
              color: Enum.random([:blue, :red, :green, :yellow, :purple, :pink, :indigo, :teal])
            },
            randomize_classes()
          )
        end)
        |> Stream.with_index()
        |> Stream.map(fn {shape, idx} -> Map.put(shape, :id, "id-#{idx}") end)
        |> Enum.take(100)
      else
        []
      end

    {:ok, assign(socket, shapes: shapes)}
  end

  def handle_info(:randomize, socket) do
    shapes =
      Enum.map(socket.assigns.shapes, fn shape ->
        Map.merge(shape, randomize_classes())
      end)

    schedule_update()
    {:noreply, assign(socket, shapes: shapes)}
  end

  defp schedule_update(milliseconds \\ 500) do
    Process.send_after(self(), :randomize, milliseconds)
  end

  defp randomize_classes do
    %{
      top: Enum.random(1..99),
      left: Enum.random(1..99),
      width: Enum.random([8, 12, 16, 20, 24]),
      height: Enum.random([8, 12, 16, 20, 24]),
      opacity: 100,
      scale: 100,
      rotation: 0
      # opacity: Enum.random([50, 75, 90, 100]),
      # scale: Enum.random([75, 90, 100, 110, 125]),
      # rotation: Enum.random([-180, -90, -45, 0, 45, 90, 180])
    }
  end

  def render(assigns) do
    ~H"""
    <div class="h-[calc(100vh-2rem)] flex flex-col">
      <h1 class="text-3xl font-bold text-white mb-2 text-center">
        LiveFlip
      </h1>
      <p class="text-lg text-white mb-3">
        <span class="underline">LiveFlip</span>
        is a component which implements Flip animations for Phoenix LiveView.
      </p>
      <p class="text-white mb-4">
        See it in action below!
      </p>

      <h2 class="text-2xl font-bold text-white mb-2">Docs and Usage</h2>
      <p class="text-white mb-4">
        You can find usage information and documentation on Hexdocs at the following link:
        <a href="https://hexdocs.pm/live_flip" class="text-gray-500 hover:text-gray-600 underline">
          https://hexdocs.pm/live_flip
        </a>
      </p>

      <div class="flex-1 bg-gray-800 rounded-lg relative p-8 overflow-hidden">
        <%= for shape <- @shapes do %>
          <.shape {shape} />
        <% end %>
      </div>
    </div>
    """
  end

  defp shape(assigns) do
    assigns =
      assign(assigns,
        height_class: height_to_class(assigns.height),
        width_class: width_to_class(assigns.width),
        shape_class: shape_to_class(assigns.type),
        color_class: color_to_class(assigns.color),
        top_class: top_to_class(assigns.top),
        left_class: left_to_class(assigns.left),
        opacity_class: opacity_to_class(assigns.opacity),
        scale_class: scale_to_class(assigns.scale),
        rotation_class: rotation_to_class(assigns.rotation)
      )

    ~H"""
    <.flip_wrap id={@id}>
      <div class={[
        "absolute",
        @width_class,
        @height_class,
        @color_class,
        @shape_class,
        "shadow-lg",
        @top_class,
        @left_class,
        @opacity_class,
        @rotation_class,
        @scale_class
      ]}>
      </div>
    </.flip_wrap>
    """
  end

  defp height_to_class(height), do: "h-#{height}"
  defp width_to_class(width), do: "w-#{width}"
  defp shape_to_class(:square), do: "rounded-lg"
  defp shape_to_class(:circle), do: "rounded-full"
  defp color_to_class(:blue), do: "bg-blue-500"
  defp color_to_class(:red), do: "bg-red-500"
  defp color_to_class(:green), do: "bg-green-500"
  defp color_to_class(:yellow), do: "bg-yellow-500"
  defp color_to_class(:purple), do: "bg-purple-500"
  defp color_to_class(:pink), do: "bg-pink-500"
  defp color_to_class(:indigo), do: "bg-indigo-500"
  defp color_to_class(:teal), do: "bg-teal-500"
  defp top_to_class(perc), do: "top-[#{perc}%]"
  defp left_to_class(perc), do: "left-[#{perc}%]"
  defp opacity_to_class(opacity), do: "opacity-#{opacity}"
  defp scale_to_class(scale), do: "scale-#{scale}"
  defp rotation_to_class(rotation) when rotation >= 0, do: "rotate-#{rotation}"
  defp rotation_to_class(rotation) when rotation < 0, do: "-rotate-#{abs(rotation)}"
end
