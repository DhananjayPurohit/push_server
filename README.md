# push_server

**Backend part of web push notifications written in Elixir**

1. Run `mix deps.get`
2. Run `mix web_push.gen.keypair`
3. Add the generated public and private keys in `config/config.exs`
4. Start the server with `iex -S mix phx.server`
