
-- Caminho completo até a raiz para um ativo específico

WITH RECURSIVE caminho_ativo AS (
  SELECT 
    id,
    nome,
    tipo,
    ativo_pai_id,
    nivel,
    CAST(nome AS TEXT) AS caminho
  FROM ativos
  WHERE id = 8  -- ⬅️ Substitua pelo ID desejado

  UNION ALL

  SELECT 
    a.id,
    a.nome,
    a.tipo,
    a.ativo_pai_id,
    a.nivel,
    CONCAT(a.nome, ' → ', c.caminho)
  FROM ativos a
  INNER JOIN caminho_ativo c ON c.ativo_pai_id = a.id
)
SELECT * FROM caminho_ativo
ORDER BY nivel;
