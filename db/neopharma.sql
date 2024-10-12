-- Criação do banco de dados
CREATE DATABASE bdNeoPharma;

-- Seleciona o banco de dados
USE bdNeoPharma;

-- Criação da tabela de usuários
CREATE TABLE tbUsuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    senha VARCHAR(255) NOT NULL,
    tipo ENUM('usuario', 'admin') NOT NULL
);

-- Criação da tabela de produtos
CREATE TABLE tbProdutos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT,
    preco DECIMAL(10, 2) NOT NULL,
    estoque INT NOT NULL
);

-- Criação da tabela de vendas
CREATE TABLE tbVendas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    data_venda DATETIME NOT NULL,
    total DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id)
);

-- Criação da tabela de itens de venda
CREATE TABLE tbItensVenda (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_venda INT NOT NULL,
    id_produto INT NOT NULL,
    quantidade INT NOT NULL,
    preco_unitario DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (id_venda) REFERENCES Vendas(id),
    FOREIGN KEY (id_produto) REFERENCES Produtos(id)
);