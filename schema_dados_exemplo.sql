
-- Criação das tabelas principais

DROP TABLE IF EXISTS ordens_servico;
DROP TABLE IF EXISTS ativos;

CREATE TABLE ativos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255),
    tipo VARCHAR(100),
    codigo VARCHAR(100),
    ativo_pai_id INT,
    nivel INT,
    FOREIGN KEY (ativo_pai_id) REFERENCES ativos(id) ON DELETE SET NULL
);

CREATE TABLE ordens_servico (
    id INT AUTO_INCREMENT PRIMARY KEY,
    ativo_id INT,
    descricao TEXT,
    status VARCHAR(50),
    FOREIGN KEY (ativo_id) REFERENCES ativos(id) ON DELETE CASCADE
);

-- Dados simulados em árvore de 4 níveis
INSERT INTO ativos (nome, tipo, codigo, ativo_pai_id, nivel) VALUES
('Fábrica SP', 'fábrica', 'SP-001', NULL, 1),
('Linha 1', 'linha', 'LIN-01', 1, 2),
('Máquina 1A', 'máquina', 'M1A', 2, 3),
('Motor Principal', 'componente', 'M1A-MOTOR', 3, 4),
('Sensor Vibração U', 'sensor', 'SEN-VIB-U', 4, 5),
('Sensor Vibração V', 'sensor', 'SEN-VIB-V', 4, 5),
('Linha 2', 'linha', 'LIN-02', 1, 2),
('Máquina 2A', 'máquina', 'M2A', 7, 3);

-- Ordens de Serviço de exemplo
INSERT INTO ordens_servico (ativo_id, descricao, status) VALUES
(3, 'Verificação de aquecimento', 'aberta'),
(5, 'Substituição de sensor', 'concluída');
