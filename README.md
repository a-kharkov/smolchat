# Smolchat

**Smolchat** is a bare-bones chat application

## Local Deployment

1. Get Docker
2. Clone repo
3. `docker compose run --rm app bin/rails db:prepare`
4. `docker compose run --rm app bash`
   * `bun install && bun run build:css`
   * Quit container
5. `docker compose run --rm app bun run build:css`
   * `nodemon` refused to cooperate, so CSS has to be built manually
   * I don't have any idea why `bun` doesn't see packages if it's run first time with Docker
   * Bun things, I guess
6. _(Optional)_ Specify port in `/.env`, e.g. `PORT=3002` (default: 3000)
7. `docker compose up`
8. _(Optional)_ Run specs
   - Unit tests: `docker compose exec -e RAILS_ENV=test app bundle exec rspec`
   - Feature tests: `docker compose exec -e RAILS_ENV=test app bundle exec cucumber`
