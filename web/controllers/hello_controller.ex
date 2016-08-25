defmodule HelloPhoenix.HelloController do

  use HelloPhoenix.Web, :controller

  plug :put_headers, %{ content_encoding: "gzip", cache_control: "max-age=3600", hacked: "questionable" }
  plug :assign_welcome_message, "Welcome Back!" when action in [:show]

  def index(conn, _params) do
    conn
      |> put_flash(:info, "Welcome to Phoenix! FLASH")
      |> put_flash(:error, "We have an error to show you")
      |> render("index.html")
  end

  def show(conn, %{"id" => id}) do
    conn
      |> assign(:messenger, id)
      |> render("show.html")
  end

  def delete(conn, _params) do
    conn
      |> put_resp_content_type("text/plain")
      |> send_resp(200, "")
  end

  defp put_headers(conn, key_values) do
    Enum.reduce key_values, conn, fn {k, v}, conn ->
      Plug.Conn.put_resp_header(conn, to_string(k), v)
    end
  end

  defp assign_welcome_message(conn, msg), do: assign(conn, :welcome, msg)

end
