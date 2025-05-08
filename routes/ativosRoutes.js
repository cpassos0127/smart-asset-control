const express = require('express');
const router = express.Router();
const ativosController = require('../controllers/ativosController');

router.get('/ativos/tree', ativosController.getAtivosTree);

module.exports = router;
