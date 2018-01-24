FROM elixir:1.6.0

ENV MIX_ENV=prod

COPY . /app
WORKDIR /app

RUN mix local.hex --force
RUN mix local.rebar --force

RUN mix deps.get --force
RUN mix compile
RUN mix release --env=prod

RUN mkdir -p /app/target

RUN tar xzf /app/_build/prod/rel/ynd_phx_bootstrap/releases/0.0.1/ynd_phx_bootstrap.tar.gz -C /app/target/

CMD ["/app/target/bin/ynd_phx_bootstrap", "foreground"]
