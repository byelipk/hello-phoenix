defmodule HelloPhoenix.HelloController do

  use HelloPhoenix.Web, :controller

  plug :put_headers, %{ content_encoding: "gzip", cache_control: "max-age=3600", hacked: "questionable" }

  def index(conn, _params) do
    conn
      |> put_flash(:info, "Welcome to Phoenix! FLASH")
      |> put_flash(:error, "We have an error to show you")
      |> render("index.html")
  end

  def show(conn, %{"messenger" => messenger}) do
    conn
      |> assign(:messenger, messenger)
      |> render("show.html")
  end

  defp put_headers(conn, key_values) do
    Enum.reduce key_values, conn, fn {k, v}, conn ->
      Plug.Conn.put_resp_header(conn, to_string(k), v)
    end
  end

end
