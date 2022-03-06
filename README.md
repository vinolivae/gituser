# Gituser

Here we have an API that searches for information about the github repository users.

Use this project if you want to understand how to consume external APIs
using phoenix framework.

Here you will find how to consume the **github** API using **tesla** and how to test it using **bypass** and **mox**.

## How to use:
- Up your docker-compose(optional).
  ```
  docker-compose up -d
  ```
- Start you Phoenix server:
  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

- Use any HTTP client to request:

  route:
  ```
  http://localhost:4000/api/user/:user_name
  ``` 
  output:
  ```json
  {"data": [objects]}
  ```

-----
## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix
