FROM node:20.11.1-alpine3.19 as npm
COPY package*.json .
RUN npm install

FROM node:20.11.1-alpine3.19 as build
ENV NODE_ENV=production

# good
# WORKDIR /app

COPY --from=npm /node_modules node_modules
COPY . .
RUN npx next build

FROM node:20.11.1-alpine3.19
WORKDIR /app

# good
# COPY --from=build /app/.next/standalone .
# COPY --from=build /app/.next/static .next/static

# bad
COPY --from=build /.next/standalone .
COPY --from=build /.next/static .next/static
