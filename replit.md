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
- Fixed `TypeError: Cannot read properties of undefined (reading 'baseUrl')` in `getModel` by adding a safety check for `ollamaInstance.config`.
- Improved Ollama model fetching in `app/utils/constants.ts` with better error handling and response validation.
- Rebuilt the project to ensure the production server has the latest changes.
- Investigated 502 Bad Gateway on remote server (93.127.142.144).
- Verified that the application is successfully running on port 8788 and responding with 200 OK.
