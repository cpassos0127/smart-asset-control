FROM node:18

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .

# ✅ Cloud Run exige expor a 8080
EXPOSE 8080

# ✅ Use a variável de ambiente PORT (será 8080)
CMD [ "node", "index.js" ]

