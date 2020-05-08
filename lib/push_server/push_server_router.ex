defmodule PushServer.Router do
  use Plug.Router
  use Plug.Debugger
  require Logger
  plug(Plug.Logger, log: :debug)

  plug(CORSPlug, origin: "*")

  plug(:match)

  plug(:dispatch)

  get "/hello" do
    send_resp(conn, 200, "world")
  end

  post "/notifications/subscribe" do
    body = ~s({"title": "Orcasound", "body": "Listen live concert now!"})
    {:ok, subs, conn} = read_body(conn)
    subs = Poison.decode!(subs)

    subscription = %{
      keys: %{p256dh: subs["keys"]["p256dh"], auth: subs["keys"]["auth"]},
      endpoint: subs["endpoint"],
      expirationTime: subs["expirationTime"]
    }

    {:ok, response} = WebPushEncryption.send_web_push(body, subscription)
    send_resp(conn, :ok, response)
  end

  # "Default" route that will get called when no other route is matched

  match _ do
    send_resp(conn, 404, "not found")
  end
end
