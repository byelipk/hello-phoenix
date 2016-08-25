require IEx

defmodule HelloPhoenix.PageController do
  use HelloPhoenix.Web, :controller

  def index(conn, _params) do
    conn
      |> show_layout
      |> render("index.html")
  end

  def test(conn, _) do
    render conn, "test.html"
  end

  defp show_layout(conn), do: conn
  defp show_layout(conn, _) do
    case conn.params do
      %{"layout" => "true"} -> conn |> put_layout("app.html")
      _default              -> conn |> put_layout(false)
    end
  end

end
