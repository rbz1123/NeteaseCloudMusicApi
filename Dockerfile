FROM node:lts-alpine

RUN apk add --no-cache tini

WORKDIR /app
RUN chown node:node /app

COPY --chown=node:node . ./

ENV NODE_ENV=production
USER node

RUN npm install --include=dev --no-audit --no-fund \
    && npm prune --omit=dev --no-audit --no-fund

EXPOSE 3000

CMD ["/sbin/tini", "--", "node", "app.js"]
