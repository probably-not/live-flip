defmodule LiveFlipDemo.LibWatcher do
  use GenServer
  require Logger
  @name __MODULE__

  def watch(_profile, _args) do
    GenServer.start(__MODULE__, %{}, name: @name)
  end

  def init(state) do
    Process.flag(:trap_exit, true)
    Process.send_after(@name, :poll_and_reload, 10_000)
    {:ok, state}
  end

  def handle_info({:EXIT, _pid, :normal}, state) do
    {:noreply, state}
  end

  def handle_info(:poll_and_reload, state) do
    current_mtimes =
      get_current_mtimes("../lib")
      |> List.flatten()
      |> Map.new()

    touched =
      Enum.reduce(current_mtimes, [], fn {file, mtime}, acc ->
        case Map.fetch(state, file) do
          {:ok, val} ->
            if val != mtime do
              [file | acc]
            else
              acc
            end

          :error ->
            acc
        end
      end)

    handle_touched(touched)
    Process.send_after(@name, :poll_and_reload, 1000)
    {:noreply, current_mtimes}
  end

  def handle_touched([]), do: :ok

  def handle_touched(files) do
    Logger.debug("Found #{length(files)} changed files")
    Logger.debug("Recompiling files...")

    case Kernel.ParallelCompiler.compile(files, return_diagnostics: true) do
      {:ok, modules, _warnings} ->
        Enum.each(modules, fn module -> Logger.debug("Compiled #{module}") end)

      {:error, errors, warnings} ->
        Logger.error(
          "Failed to compile with errors and warnings\nErrors: #{inspect(errors)}\nWarnings: #{inspect(warnings)}"
        )
    end

    :ok
  end

  def get_current_mtimes(dir) do
    case File.ls(dir) do
      {:ok, files} ->
        get_current_mtimes(files, [], dir)

      _ ->
        nil
    end
  end

  def get_current_mtimes([], mtimes, _cwd) do
    mtimes
    |> Enum.sort()
    |> Enum.reverse()
  end

  def get_current_mtimes([head | tail], mtimes, cwd) do
    mtime =
      case File.dir?("#{cwd}/#{head}") do
        true -> get_current_mtimes("#{cwd}/#{head}")
        false -> {Path.expand("#{cwd}/#{head}"), File.stat!("#{cwd}/#{head}").mtime}
      end

    get_current_mtimes(tail, [mtime | mtimes], cwd)
  end
end
