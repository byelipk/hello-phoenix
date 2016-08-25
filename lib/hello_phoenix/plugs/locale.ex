defmodule HelloPhoenix.Plugs.Locale do
  @moduledoc """
  This is a practice module that will inject a locale setting
  into the Plug.Conn struct.
  """

  import Plug.Conn

  @locales ["en"]

  def init(default), do: default

  def call(%Plug.Conn{params: %{"locale" => loc}} = conn, _default) when loc in @locales do
    assign(conn, :locale, loc)
  end

  def call(conn, default), do: assign(conn, :locale, default)
end
