defmodule LiveFlipDemoWeb.CoreComponents.Perf do
  use Phoenix.Component

  def perf(assigns) do
    ~H"""
    <script>
      let frames = 0;
      let lastTime = performance.now();

      function checkFrameRate() {
        frames++;
        const currentTime = performance.now();

        if (currentTime - lastTime > 1000) {
          document.getElementById("fps").textContent = frames;
          frames = 0;
          lastTime = currentTime;
        }

        requestAnimationFrame(checkFrameRate);
      }

      requestAnimationFrame(checkFrameRate);
    </script>

    <div class="z-[100] absolute top-4 right-4 bg-black bg-opacity-40 text-white p-4 rounded-lg pointer-events-none">
      <div>FPS: <span id="fps">0</span></div>
    </div>
    """
  end
end
