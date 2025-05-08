const pool = require('../config/db');

exports.getAtivosTree = async (req, res) => {
  try {
    const result = await pool.query(`
      WITH RECURSIVE ativos_tree AS (
        SELECT
          e.id AS id_empresa,
          e.nome AS nome_empresa,
          u.id AS id_unidade,
          u.nome AS nome_unidade,
          a.id AS id_area,
          a.nome AS nome_area,
          s.id AS id_setor,
          s.nome AS nome_setor,
          eq.id AS id_equipamento,
          eq.nome AS nome_equipamento,
          c.id AS id_componente,
          c.nome AS nome_componente,
          pm.id AS id_ponto_medicao,
          pm.descricao AS nome_ponto_medicao
        FROM empresas e
        LEFT JOIN unidades u ON u.empresa_id = e.id
        LEFT JOIN areas a ON a.unidade_id = u.id
        LEFT JOIN setores s ON s.area_id = a.id
        LEFT JOIN equipamentos eq ON eq.setor_id = s.id
        LEFT JOIN componentes c ON c.equipamento_id = eq.id
        LEFT JOIN pontos_medicao pm ON pm.componente_id = c.id
      )
      SELECT * FROM ativos_tree;
    `);
    res.status(200).json(result.rows);
  } catch (err) {
    console.error('Erro ao buscar árvore de ativos:', err);
    res.status(500).json({ error: 'Erro interno ao montar árvore de ativos' });
  }
};
