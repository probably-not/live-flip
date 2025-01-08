defmodule LiveFlipDemoWeb.HomeLive do
  use LiveFlipDemoWeb, :live_view

  import LiveFlip

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <div class="max-w-4xl mx-auto px-4 py-12">
      <h1 class="text-3xl font-bold text-center mb-8">
        LiveFlip
      </h1>
      <p class="text-lg mb-6">
        <span class="underline">LiveFlip</span> is a component which implements Flip animations for Phoenix LiveView.
      </p>
      <p class="mb-8">
        See it in action here!
      </p>

      <h2 class="text-2xl font-bold mb-4">Docs and Usage</h2>
      <p class="mb-8">
        You can find usage information and documentation on Hexdocs at the following link:
        <a href="https://hexdocs.pm/live_flip" class="text-gray-600 hover:text-gray-900 underline">
          https://hexdocs.pm/live_flip
        </a>
      </p>
    </div>
    """
  end
end
