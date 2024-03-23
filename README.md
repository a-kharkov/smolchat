# Smolchat

**Smolchat** is a bare-bones chat application

## Local Deployment

1. Get Docker
2. Clone repo
3. `docker compose run --rm app bin/rails db:prepare`
4. `docker compose run --rm app bash`
   * `bun install && bun run build:css`
   * Quit container
6. `docker compose run --rm app bun run build:css`
   * `nodemon` refused to cooperate, so CSS has to be built manually
   * I don't have any idea why `bun` doesn't see packages if it's run first time with Docker
   * Bun things, I guess
7. Optional: specify port in `/.env`, e.g. `PORT=3002` (default: 3000)
8. `docker compose up`
