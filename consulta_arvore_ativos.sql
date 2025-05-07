
-- Consulta recursiva para visualizar a árvore de ativos com 8 níveis
WITH RECURSIVE arvore_ativos AS (
  SELECT 
    id,
    nome,
    tipo,
    codigo,
    ativo_pai_id,
    nivel,
    ARRAY[nome] AS caminho
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
    aa.caminho || a.nome
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
  array_to_string(caminho, ' → ') AS caminho_completo
FROM arvore_ativos
ORDER BY caminho;
