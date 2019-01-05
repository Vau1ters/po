defmodule Secom.Sensor.Thermometer do
  def start(pid) do
    IO.inspect "thermo 0"
    loop(pid)
  end
  def loop(pid) do
    try do
      {up, _, _, _} = Secom.Joystick.get_direction()
      t = if(up) do
        50
      else
        30
      end
      send pid, %Secom.Event{type: :thermometer, value: t}
      :timer.sleep(500)
    catch
      _, e -> IO.puts "error: #{inspect e}"
        IO.puts "まだ起動してない"
    end
    loop(pid)
  end
end
