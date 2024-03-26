# Smolchat

**Smolchat** is a bare-bones chat application

## Local Deployment

1. Get Docker
2. Clone repo
3. `docker compose run --rm app bin/rails db:prepare`
4. `docker compose run --rm app bun run build:css`
   * `nodemon` refused to cooperate, so CSS has to be built manually
5. _(Optional)_ Specify port in `/.env`, e.g. `PORT=3002` (default: 3000)
6. `docker compose up`
7. _(Optional)_ Run specs
   - Unit tests: `docker compose exec app bundle exec rspec`
   - Feature tests: `docker compose exec -e test app bundle exec cucumber`
