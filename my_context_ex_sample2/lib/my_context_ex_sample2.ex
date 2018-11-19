defmodule MyContextExSample2 do
  def start() do
    ContextEX.start()
    Python.init()
    actors = for n <- [0, 1, 3] do
      IO.inspect n
      actor_pid = Router.route(n, MyContextExSample2.Actor, :start, [])
      Router.route(n, MyContextExSample2.Sensor.SmokeSensor, :start, [actor_pid])
      Router.route(n, MyContextExSample2.Sensor.Thermometer, :start, [actor_pid])
    end
  end
end
