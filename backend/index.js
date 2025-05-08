const express = require('express');
const app = express();
const ativosRoutes = require('./routes/ativosRoutes');

app.use(express.json());
app.use('/api', ativosRoutes);

app.listen(3000, () => {
  console.log("Servidor rodando na porta 3000");
});
