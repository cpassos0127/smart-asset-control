const express = require('express');
const app = express();

app.get('/', (req, res) => {
  res.send('API Smart Asset Control funcionando!');
});

// AQUI É O PONTO CRÍTICO 👇
const PORT = process.env.PORT || 8080;

app.listen(PORT, () => {
  console.log(`Servidor rodando na porta ${PORT}`);
});


