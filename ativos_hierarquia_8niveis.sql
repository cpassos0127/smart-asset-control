
-- Reset
DROP TABLE IF EXISTS ativos CASCADE;

-- Criação da tabela de ativos com hierarquia
CREATE TABLE ativos (
  id SERIAL PRIMARY KEY,
  nome TEXT NOT NULL,
  tipo TEXT,
  codigo TEXT UNIQUE,
  ativo_pai_id INTEGER REFERENCES ativos(id),
  nivel SMALLINT,
  criado_em TIMESTAMP DEFAULT NOW()
);

-- Inserção simulada de ativos com 8 níveis
INSERT INTO ativos (nome, tipo, codigo, ativo_pai_id, nivel) VALUES
-- Nível 1
('Fábrica São Paulo', 'fábrica', 'FAB-SP', NULL, 1),

-- Nível 2
('Linha Produção 01', 'linha', 'FAB-SP-LIN01', 1, 2),

-- Nível 3
('Sistema Ventilação', 'sistema', 'FAB-SP-LIN01-SISV', 2, 3),

-- Nível 4
('Conjunto Exaustores', 'conjunto', 'FAB-SP-LIN01-SISV-CJEX', 3, 4),

-- Nível 5
('Motor Exaustor 01', 'máquina', 'FAB-SP-LIN01-SISV-CJEX-MOT01', 4, 5),

-- Nível 6
('Enrolamento Estator', 'componente', 'FAB-SP-LIN01-SISV-CJEX-MOT01-EST', 5, 6),

-- Nível 7
('Fase U', 'subcomponente', 'FAB-SP-LIN01-SISV-CJEX-MOT01-EST-U', 6, 7),

-- Nível 8
('Sensor Vibração Fase U', 'sensor', 'FAB-SP-LIN01-SISV-CJEX-MOT01-EST-U-SENS01', 7, 8);
