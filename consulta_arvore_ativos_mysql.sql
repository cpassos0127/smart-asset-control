
-- Consulta recursiva de árvore hierárquica compatível com MySQL Workbench (MySQL 8.0+)
WITH RECURSIVE arvore_ativos AS (
  SELECT 
    id,
    nome,
    tipo,
    codigo,
    ativo_pai_id,
    nivel,
    CAST(nome AS CHAR(1000)) AS caminho_completo
  FROM ativos
  WHERE ativo_pai_id IS NULL

  UNION ALL

  SELECT 
    a.id,
    a.nome,
    a.tipo,
    a.codigo,
    a.ativo_pai_id,
    a.nivel,
    CONCAT(aa.caminho_completo, ' → ', a.nome) AS caminho_completo
  FROM ativos a
  INNER JOIN arvore_ativos aa ON a.ativo_pai_id = aa.id
)

SELECT 
  id,
  nome,
  tipo,
  codigo,
  ativo_pai_id,
  nivel,
  caminho_completo
FROM arvore_ativos
ORDER BY caminho_completo;
