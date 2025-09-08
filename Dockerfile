# Start from the official n8n image you were using on Render
FROM docker.n8n.io/n8nio/n8n:latest

# Switch to root so we can install packages
USER root

# Install LangChain nodes (and others if you want later)
RUN npm install --omit=dev --no-package-lock --legacy-peer-deps @n8n/n8n-nodes-langchain@latest \
    && npm cache clean --force

# Fix permissions so the "node" user (default in n8n image) can use the installed packages
RUN chown -R node:node /usr/local/lib/node_modules /home/node/.npm /home/node/.config /data

# Switch back to node user (n8n expects this)
USER node
