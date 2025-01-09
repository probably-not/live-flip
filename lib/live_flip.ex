defmodule LiveFlip do
  @moduledoc """
  `LiveFlip` is a component for `Phoenix.LiveView` that allows the user to seamlessly add FLIP animations to their elements on the page.
  """

  use Phoenix.Component

  @doc """
  Wraps an element with a FLIP animation.
  The element can be subsequently changed by changing its styling.
  Any change that has to do with positioning, scale, rotation, or opacity
  will be automatically animated through the FLIP technique.

  FLIP stands for First, Last, Invert, Play. It is an animation technique coined by
  Paul Lewis in his article [FLIP Your Animations](https://aerotwist.com/blog/flip-your-animations/),
  which describes the technique in detail. The technique has subsequently been added to
  many major libraries, as it adds the capability to seamlessly move elements around on a page.

  [INSERT LVATTRDOCS]

  ## Examples

  Simply render your inner content within this component and move it around the page by adjusting
  its classes. The element will automatically animate its movement. You can also change the scale,
  rotation, and opacity, all of which will animate as the element is adjusted:

  ```heex
  <.flip_wrap id="my-red-square">
    <div class="absolute w-16 h-16 bg-red-500 rounded-lg shadow-lg">
    </div>
  </.flip_wrap>
  ```
  """
  @doc type: :component
  attr :id, :string, required: true, doc: "The DOM identifier of the flip container tag."
  attr :duration, :integer, required: false, default: 300, doc: "The duration that the animation will last."

  attr :easing, :string,
    required: false,
    default: "ease-in-out",
    doc: "The easing function to pass to the Web Animation API."

  attr :fill, :string, required: false, default: "both", doc: "The fill function to pass to the Web Animation API."
  attr :debug, :boolean, default: false, doc: "Add debug logs to the frontend so that you can debug the animations"
  attr :rest, :global, doc: "Additional HTML attributes to add to the flip container tag."
  slot :inner_block, required: true, doc: "The content rendered inside of the flip container tag."

  def flip_wrap(assigns) do
    ~H"""
    <div
      id={@id}
      phx-hook="Flip"
      data-duration={@duration}
      data-easing={@easing}
      data-fill={@fill}
      data-debug={@debug}
      {@rest}
    >
      {render_slot(@inner_block)}
    </div>
    """
  end
end
