# Sooks Sandwich Shop

This is a side project for me to get some practice in building Rails Applications. The end result will be a Rails Web App for a fake sandwich eCommerce shop that allows users to order sandwiches and for admins and employees to manage those orders. The prompt for this project comes from [Fake Clients](https://fakeclients.com).

Inspiration and help with the initial skeleton of this application comes from [this article on building an eCommerce Platform](https://web-crunch.com/ruby-on-rails-ecommerce-music-shop/).

Prompt:

> I'm Sook, I just founded a new business called Sook's Sandwich bar Shop. For a while now, I've been looking for a good website for my business.
> We need a new login-page for our employee web portal. Can you help us out?

## Tech Stack

- Ruby 2.6.4
- Rails 6.0.0
- Docker

## Getting Started

To get this application started, run the following commands:

```bash
  docker-compose run web rails new . --database=postgresql
```

After the application is initially created using the above command, build the docker image

```bash
  docker-compose build
```

Once the image is created, connect the app to the database in `config/database.yml`

```yml
default: &default
  adapter: postgresql
  encoding: unicode
  host: db
  username: postgres
  password:
  pool: 5

development:
  <<: *default
  database: myapp_development


test:
  <<: *default
  database: myapp_test
```

Finally, run the following commands to start the database and create it

```bash
  docker-compose up
  docker-compose run web rake db:create
```

## References

- https://medium.com/@kennethteh90/how-to-build-a-basic-e-commerce-store-909f2893be71
-
