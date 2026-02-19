# bolt.diy

## Overview
bolt.diy is an open-source AI-powered full-stack web development assistant that runs in the browser. It allows users to choose from multiple LLM providers (OpenAI, Anthropic, Google, Groq, OpenRouter, Mistral, xAI, HuggingFace, DeepSeek, Cohere, and more) to generate and manage code projects via a chat interface with an integrated WebContainer-based development environment.

## Project Architecture
- **Framework**: Remix (React) with Vite as the build tool
- **Runtime**: Originally designed for Cloudflare Workers, adapted for Node.js on Replit
- **Package Manager**: pnpm
- **Language**: TypeScript
- **Styling**: UnoCSS + SCSS
- **Key Dependencies**: Vercel AI SDK, WebContainer API, CodeMirror, xterm.js

## Project Structure
```
app/
  components/    - React UI components (chat, editor, sidebar, header, etc.)
  lib/           - Core libraries
    .server/     - Server-side code (LLM integration)
    stores/      - Nanostores state management
    hooks/       - React hooks
    persistence/ - Chat history persistence
  routes/        - Remix routes (pages + API endpoints)
  styles/        - SCSS styles
  types/         - TypeScript type definitions
  utils/         - Utility functions
```

## Key Configuration
- **Vite**: Configured in `vite.config.ts` - port 5000, host 0.0.0.0, all hosts allowed
- **Entry Server**: `app/entry.server.tsx` - Uses Node.js `renderToPipeableStream` (adapted from Cloudflare's `renderToReadableStream`)
- **API Routes**: `app/routes/api.chat.ts`, `app/routes/api.enhancer.ts` - Use `process.env` fallback for environment variables

## Environment Variables
API keys are set via environment variables or entered in the UI:
- ANTHROPIC_API_KEY, OPENAI_API_KEY, GROQ_API_KEY, GOOGLE_GENERATIVE_AI_API_KEY
- OPEN_ROUTER_API_KEY, DEEPSEEK_API_KEY, MISTRAL_API_KEY, XAI_API_KEY
- PERPLEXITY_API_KEY, HuggingFace_API_KEY, COHERE_API_KEY
- TOGETHER_API_KEY, OPENAI_LIKE_API_KEY

## Recent Changes (2026-02-19)
- Investigated 502 Bad Gateway on remote server (93.127.142.144).
- Identified that Nginx is proxying to port 8788, but no process is listening on that port.
- Found a Node process running `/home/administrator/bolt/build/server/index.js` but it wasn't bound to the expected port or was unstable.
- Attempted to restart the application using `pnpm run start`.
- Fixed PM2 start command for the 'bolt' process. The issue was due to incorrect argument passing (`--node-args`) when using `npm start`.
- Switched to using `PORT=8788` environment variable with direct `node` execution of `remix-serve` in PM2 to ensure the application listens on the correct port and bypasses argument parsing issues.
- Verified that the application is successfully running on port 8788 and responding with 200 OK.
- Adapted from Cloudflare Workers to Node.js runtime for Replit compatibility
- Removed `cloudflareDevProxyVitePlugin` from Vite config
- Switched imports from `@remix-run/cloudflare` to `@remix-run/node`
- Rewrote entry.server.tsx to use Node.js streaming APIs
- Configured Vite dev server for Replit (port 5000, allowedHosts: true)
- Connected to external server at 93.127.142.144 via sshpass.
- Fixed PM2 start command for the 'bolt' process. The issue was due to incorrect argument passing (`--node-args`) when using `npm start`.
- Switched to using `PORT=8788` environment variable with direct `node` execution of `remix-serve` in PM2 to ensure the application listens on the correct port and bypasses argument parsing issues.
- Verified that the application is successfully running on port 8788 and responding with 200 OK.
