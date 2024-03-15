-- Criação da tabela para categorias de despesas
CREATE TABLE categorias (
    categoria_id INT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL
);

-- Exemplo de inserção de algumas categorias de despesas
INSERT INTO categorias (categoria_id, nome) VALUES
(1, 'Alimentação'),
(2, 'Aluguel/Prestação'),
(3, 'Transporte'),
(4, 'Saúde'),
(5, 'Estudos'),
(6, 'Lazer'),
(7, 'Reservas');

-- Criação da tabela para despesas
CREATE TABLE despesas (
    despesa_id INT PRIMARY KEY,
    categoria_id INT,
    descricao VARCHAR(100),
    valor DECIMAL(10, 2),
    data DATE,
    FOREIGN KEY (categoria_id) REFERENCES categorias(categoria_id)
);

-- Exemplo de inserção de algumas despesas
INSERT INTO despesas (despesa_id, categoria_id, descricao, valor, data) VALUES
(1, 1, 'Resenhas com amigos', 50.00, '2024-02-27'),
(2, 3, 'Resenhas com namorada', 80.00, '2024-02-26'),
(3, 6, 'Emergências', 30.00, '2024-02-25');

-- Criação da tabela para métodos de pagamento
CREATE TABLE metodos_pagamento (
    metodo_id INT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL
);

-- Exemplo de inserção de alguns métodos de pagamento
INSERT INTO metodos_pagamento (metodo_id, nome) VALUES
(1, 'Dinheiro'),
(2, 'Cartão de Crédito'),
(3, 'Cartão de Débito'),
(4, 'Pix');

-- Criação da tabela para usuários
CREATE TABLE usuarios (
    usuario_id INT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    senha VARCHAR(100) NOT NULL
);

-- Exemplo de inserção de um usuário
INSERT INTO usuarios (usuario_id, nome, email, senha) VALUES
(1, 'Nome do Usuário', 'usuario@email.com', 'senha123');

-- Modificação da tabela de despesas para incluir o usuário e o método de pagamento
ALTER TABLE despesas
ADD COLUMN usuario_id INT,
ADD COLUMN metodo_id INT,
ADD FOREIGN KEY (usuario_id) REFERENCES usuarios(usuario_id),
ADD FOREIGN KEY (metodo_id) REFERENCES metodos_pagamento(metodo_id);

-- Exemplo de inserção de algumas despesas com informações adicionais
INSERT INTO despesas (despesa_id, categoria_id, descricao, valor, data, usuario_id, metodo_id) VALUES
(4, 4, 'Consulta Médica', 100.00, '2024-02-25', 1, 2),
(5, 5, 'Material Escolar', 50.00, '2024-02-26', 1, 4),
(6, 6, 'Ingresso para Parque de Diversões', 40.00, '2024-02-27', 1, 3);


