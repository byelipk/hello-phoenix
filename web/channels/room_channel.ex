defmodule HelloPhoenix.RoomChannel do
  use Phoenix.Channel

  @doc """
  Anyone who join the `room:lobby` channel is
  good to go.
  """
  def join("room:lobby", _message, socket) do
    {:ok, socket}
  end

  @doc """
  All other channels are noops!
  """
  def join("room:" <> _private_room_id, _params, _socket) do
    {:error, %{reason: "unauthorized"}}
  end

  @doc """
  broadcast!/3 will notify all joined clients on this
  socket's topic and invoke their `handle_out/3` callbacks.
  """
  def handle_in("new_msg", %{"body" => body}, socket) do
    broadcast!(socket, "new_msg", %{body: body})
    {:noreply, socket}
  end

  @doc """
  `handle_out/3` isn't a required callback, but it allows
  us to customize and filter broadcasts before they reach
  each client.
  """
  def handle_out("new_msg", payload, socket) do
    push socket, "new_msg", payload
    {:noreply, socket}
  end
end
