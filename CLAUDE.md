# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a full-stack web application for the Chichester Community Choir built with Gleam. It uses a monorepo structure with three main packages:

- **client**: Lustre SPA (Single Page Application) compiled to JavaScript
- **server**: Wisp/Mist backend running on Erlang/BEAM with SQLite database
- **shared**: Common types and utilities shared between client and server

The application uses server-side rendering (SSR) with client-side hydration. The server renders initial HTML with embedded JSON state, which the client hydrates into an interactive SPA.

## Architecture

### Monorepo Structure

```
client/          - Frontend Lustre application (JavaScript target)
  src/client/
    routes/      - Route-specific view components
    components/  - Reusable UI components
    lib/         - Client utilities (model, msg, decoder, route)
    env.gleam    - Generated at build time with API_URL

server/          - Backend Wisp/Mist application (Erlang target)
  src/server/
    routes/      - API and auth route handlers
    db/          - Database migrations and queries
    lib/         - Server utilities (encoder)
    router.gleam - Main request router with API and page routes
  priv/static/   - Built client assets served by server

shared/          - Shared types (Song, Post, AuthUser)
```

### Client Architecture

- **Lustre SPA**: Uses The Elm Architecture (TEA) with Model-View-Update pattern
- **Routing**: Client-side routing with route.gleam, synchronized with server routes
- **State Management**: Single model with centralized update function
- **Hydration**: Initial state injected as JSON in `<script id="model">` tag
- **API Communication**: lustre_http for API calls to server

### Server Architecture

- **Web Framework**: Wisp (request handling) + Mist (HTTP server) on BEAM
- **Routing**: Two-tier routing:
  - API routes (`/api/*`): REST endpoints returning JSON
  - Page routes (`/*`): SSR with hydration, protected by session
- **Authentication**: Session-based with in-memory cache (session_cache.gleam)
- **Database**: SQLite via sqlight + cake query builder
- **SSR**: Server renders Lustre components to HTML with initial state

### Request Flow

1. Browser requests page (e.g., `/events`)
2. Server router (router.gleam) matches route
3. Protected routes check session via `user_session.get_user_from_session()`
4. Server fetches data, creates Model with initial state
5. Server renders Lustre view to HTML via `client.view(model)`
6. HTML includes initial state as JSON in `<script id="model">`
7. Client JavaScript hydrates: parses JSON, initializes Lustre app
8. Client handles subsequent interactions via API calls

## Development Commands

### Setup

Nix flake environment provides: gleam, erlang_27, rebar3, bun

```bash
nix develop  # Enter development shell
```

### Build and Run

```bash
# Development mode (unminified)
./run-dev.sh
# 1. cd client && bun install
# 2. Generate env.gleam with API_URL
# 3. Build client: gleam run -m lustre/dev build --outdir=../server/priv/static
# 4. cd server && gleam run

# Production mode (minified)
./run-ssr.sh
# Same as dev but adds --minify flag to lustre/dev build
```

### Individual Package Commands

```bash
# Client
cd client
gleam build                              # Build client
gleam test                               # Run client tests
gleam run -m lustre/dev build --outdir=../server/priv/static  # Build to server static dir
gleam run -m lustre/dev build --outdir=../server/priv/static --minify  # Minified build

# Server
cd server
gleam build                              # Build server
gleam test                               # Run server tests
gleam run                                # Run server (default: 127.0.0.1:8080)
gleam run -- --host localhost --port 3000  # Custom host/port

# Shared
cd shared
gleam build                              # Build shared types
gleam test                               # Run shared tests

# Any package
gleam format                             # Format code
gleam check                              # Type check without building
```

## Key Files

- **server/src/server.gleam**: Entry point, initializes migrations, session cache, starts Mist server
- **server/src/server/router.gleam**: Request routing with `api_routes()` and `page_routes()`
- **server/src/server/db/migrations.gleam**: Database schema initialization
- **server/src/server/db/user_session.gleam**: Session management
- **client/src/client.gleam**: Client entry point with Lustre init/update/view
- **client/src/client/lib.gleam**: Client-side effects and API calls
- **client/src/client/lib/route.gleam**: Route type definition (must match server routes)
- **server/src/server/scaffold.gleam**: HTML scaffold with meta tags
- **shared/src/shared.gleam**: Shared types (Song, Post, AuthUser)

## Important Conventions

### Route Synchronization

Client routes (client/lib/route.gleam) and server routes (server/router.gleam) must stay in sync. Both define the same route structure.

### Environment Variable Handling

`client/src/client/env.gleam` is generated at build time by run scripts. It's gitignored. Contains `pub fn get_api_url() -> String`.

### Authentication Flow

- Login via `/api/auth/login` creates session
- Session stored in memory cache (server/routes/cache/session_cache.gleam)
- Validation via `/api/auth/validate` checks session
- Protected routes use `protected_route()` helper
- Two roles: User, Admin (defined in shared/shared.gleam)

### Database Operations

- Use cake query builder with SQLite dialect
- Queries in server/db/*.gleam modules
- Execute via server/db.gleam helpers: `execute_read()`, `execute_write()`
- Database file: `file:lfs.db`

## Testing

Single test example exists at client/src/client/routes/status_test.gleam.

Run tests:
```bash
cd client && gleam test
cd server && gleam test
cd shared && gleam test
```
