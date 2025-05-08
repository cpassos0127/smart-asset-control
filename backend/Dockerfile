
# Etapa base
FROM node:18

# Criar diretório de trabalho
WORKDIR /app

# Copiar arquivos do projeto
COPY package*.json ./
RUN npm install

COPY . .

# Expor a porta padrão da aplicação
EXPOSE 3000

# Comando de execução
CMD [ "node", "index.js" ]
