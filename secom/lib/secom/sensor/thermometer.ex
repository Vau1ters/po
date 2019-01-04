defmodule Secom.Sensor.Thermometer do
  def start(pid) do
    IO.inspect "thermo 0"
    loop(pid)
  end
  def loop(pid) do
    try do
      [_action, direction] = Python.call(:wait_for_event, [])
      t = if(direction == 'up') do
        50
      else
        30
      end
      send pid, %Secom.Event{type: :thermometer, value: t}
      IO.puts Process.whereis(:iex), "thermometer updated"
      IO.puts Process.whereis(:iex), "node:#{inspect node()}, #{inspect t}"
      :timer.sleep(200)
    catch
      _, e -> IO.puts Process.whereis(:iex), "error: #{inspect e}"
        IO.puts Process.whereis(:iex), "まだ起動してない"
    end
    loop(pid)
  end
end
