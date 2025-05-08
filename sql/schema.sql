
-- Criação do banco (caso ainda não exista, mas use com cautela se estiver logado no postgres)
-- CREATE DATABASE smart;

-- Conecte-se ao banco smart antes de rodar esse script

-- Tabela: usuarios
CREATE TABLE IF NOT EXISTS usuarios (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    senha VARCHAR(100),
    role VARCHAR(50),
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabela: ativos (com hierarquia)
CREATE TABLE IF NOT EXISTS ativos (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    tipo VARCHAR(50),
    ativo_pai_id INT REFERENCES ativos(id) ON DELETE SET NULL,
    localizacao VARCHAR(200),
    status VARCHAR(50),
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabela: ordens_servico
CREATE TABLE IF NOT EXISTS ordens_servico (
    id SERIAL PRIMARY KEY,
    ativo_id INT REFERENCES ativos(id) ON DELETE CASCADE,
    descricao TEXT,
    status VARCHAR(50),
    prioridade VARCHAR(20),
    responsavel VARCHAR(100),
    criada_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
