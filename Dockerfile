# Estágio 1: Construir a aplicação
FROM node:20-alpine as builder
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build  # Assumindo que há um script de build

# Estágio 2: Configuração do ambiente de produção
FROM node:20-alpine
WORKDIR /app
COPY --from=builder /app/build /app
COPY --from=builder /app/node_modules /app/node_modules
EXPOSE 3000
CMD ["node", "app.js"]
