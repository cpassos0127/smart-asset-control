# 🚀 Smart Asset Control

Plataforma de monitoramento inteligente de ativos elétricos, com backend Node.js e deploy automatizado via GitHub Actions e Google Cloud Run.

---

## 🧱 Estrutura do Projeto

```
smart-asset-control/
├── backend/               # Backend Node.js com Express
│   ├── Dockerfile         # Containerização para Cloud Run
│   └── index.js           # API principal
├── sql/                   # Scripts de criação de banco PostgreSQL
├── .github/workflows/     # CI/CD com GitHub Actions
└── README.md              # Documentação do projeto
```

---

## 🛠️ Tecnologias

- **Node.js 18**
- **Express.js**
- **PostgreSQL (Cloud SQL - GCP)**
- **GitHub Actions (CI/CD)**
- **Google Cloud Run**
- [ ] Firebase Authentication (em breve)

---

## ⚙️ Execução Local

### 1. Configure o ambiente

Crie o arquivo `.env` com as seguintes variáveis:

```
PGUSER=postgres
PGPASSWORD=<sua_senha>
PGHOST=localhost
PGPORT=5432
PGDATABASE=smart
```

### 2. Instale dependências e execute

```bash
cd backend
npm install
node index.js
```

Acesse via [http://localhost:3000](http://localhost:3000)

---

## 🐳 Deploy Automático (CI/CD)

Cada `push` na branch `main` executa:

- Build do backend
- Deploy automático para o Cloud Run (região `southamerica-east1`)
- CI via GitHub Actions

---

## 📡 Conexão com PostgreSQL (remoto via SSL)

Configure `db_pg_ssl.js` com:

```js
ssl: {
  rejectUnauthorized: true,
  ca: fs.readFileSync(path.join(__dirname, 'server-ca.pem')).toString()
}
```

---

## 👨‍💻 Desenvolvido por

Cleverson Passos – [Smart Asset Control](https://github.com/cpassos0127)