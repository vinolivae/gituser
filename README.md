# Gituser

Here we have an API that searches for information about the github repository users.

Use this project if you want to understand how to consume external APIs
using phoenix framework and authenticate with guardian lib.

Here you will find how to consume the **github** API using **tesla**, how to test it using **bypass** and **mox** but you need a token for this, hehe.

## How to use:
- Up your docker-compose(optional if you have all setup locally).
  ```
  docker-compose up -d
  ```
- Start you Phoenix server:
  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

- Use any HTTP client to request:

### routes
___
  GET
  ```
   http://localhost:4000/api/user/:user_name
  ``` 
  output:
  ```json
  {"data": [objects]}
  ```
___
  POST
  ```
  http://localhost:4000/api/user
  ```
  body
  ```json
  {"password": "secure_password"}
  ```
  output
  ```json
  {
    "message": "User created!",
    "user": {
      "id": uuid,
      "password": hash
    }
  }
  ```
___
POST
  ```
  http://localhost:4000/api/user/login
  ```
  body
  ```json
  {"password": "secure_password", "id": uuid}
  ```
  output
  ```json
  {
    "message": "User signined!",
    "token": JWT
  }
  ```
---
## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix
