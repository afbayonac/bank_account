# BankAccounts

To start your Phoenix server:

  * Run `mix setup` to install and setup dependencies
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix

## Database

´´´bash
docker run --name phx-postgres -e POSTGRES_PASSWORD=postgres -p 5432:5432 -d postgres
mix phx.gen.json Holders Holder holders name:string address:string birth:date phone:string
mix phx.gen.json Accounts Account accounts number:string holder_id:references:holders
mix phx.gen.json Movements Movement movements amount:integer from_id:references:accounts to_id:references:accounts timestamp:utc_datetime

´´´

