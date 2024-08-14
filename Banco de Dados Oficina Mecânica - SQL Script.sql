-- Criando o banco de dados
CREATE DATABASE IF NOT EXISTS Oficina;
USE Oficina;

-- Criando a tabela Cliente
CREATE TABLE IF NOT EXISTS Cliente (
    idCliente INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(100) NOT NULL,
    Endereco VARCHAR(150),
    Telefone VARCHAR(20)
);

-- Criando a tabela Veiculo
CREATE TABLE IF NOT EXISTS Veiculo (
    Placa VARCHAR(10) PRIMARY KEY,
    Modelo VARCHAR(50) NOT NULL,
    Marca VARCHAR(50),
    Ano INT CHECK (Ano >= 1886), -- O primeiro automóvel foi criado em 1886
    idCliente INT,
    FOREIGN KEY (idCliente) REFERENCES Cliente(idCliente)
);

-- Criando a tabela da Equipe Responsavel
CREATE TABLE IF NOT EXISTS Equipe_Responsavel (
    idEquipe INT PRIMARY KEY AUTO_INCREMENT,
    NomeEquipe VARCHAR(100) NOT NULL
);

-- Criando a tabela Mecanico
CREATE TABLE IF NOT EXISTS Mecanico (
    idMecanico INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(100) NOT NULL,
    Endereco VARCHAR(150),
    Especialidade VARCHAR(50),
    idEquipe INT,
    FOREIGN KEY (idEquipe) REFERENCES Equipe_Responsavel(idEquipe)
);

-- Criando a tabela Servico
CREATE TABLE IF NOT EXISTS Servico (
    idServico INT PRIMARY KEY AUTO_INCREMENT,
    Descricao VARCHAR(100) NOT NULL,
    ValorMaoDeObra DECIMAL(10,2) NOT NULL CHECK (ValorMaoDeObra >= 0)
);

-- Criando a tabela Ordem de Servico
CREATE TABLE IF NOT EXISTS Ordem_de_Servico (
    idOrdem INT PRIMARY KEY AUTO_INCREMENT,
    DataEmissao DATE NOT NULL,
    Status VARCHAR(20) CHECK (Status IN ('Concluído', 'Em Progresso', 'Pendente')),
    DataEntrega DATE,
    PlacaVeiculo VARCHAR(10),
    idEquipe INT,
    FOREIGN KEY (PlacaVeiculo) REFERENCES Veiculo(Placa),
    FOREIGN KEY (idEquipe) REFERENCES Equipe_Responsavel(idEquipe)
);

-- Criando a tabela Pecas
CREATE TABLE IF NOT EXISTS Pecas (
    idPeca INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(100) NOT NULL,
    Quantidade INT NOT NULL CHECK (Quantidade > 0),
    ValorUnitario DECIMAL(10,2) NOT NULL CHECK (ValorUnitario >= 0)
);

-- Criando a tabela Ordem Pecas
CREATE TABLE IF NOT EXISTS Ordem_Pecas (
    idOrdem INT,
    idPeca INT,
    Quantidade INT NOT NULL CHECK (Quantidade > 0),
    PRIMARY KEY (idOrdem, idPeca),
    FOREIGN KEY (idOrdem) REFERENCES Ordem_de_Servico(idOrdem),
    FOREIGN KEY (idPeca) REFERENCES Pecas(idPeca)
);

-- Criando a tabela Ordem Servico
CREATE TABLE IF NOT EXISTS Ordem_Servico (
    idOrdem INT,
    idServico INT,
    PRIMARY KEY (idOrdem, idServico),
    FOREIGN KEY (idOrdem) REFERENCES Ordem_de_Servico(idOrdem),
    FOREIGN KEY (idServico) REFERENCES Servico(idServico)
);

-- // Inserção de Dados // --

-- Inserindo dados na tabela Cliente
INSERT INTO Cliente (Nome, Endereco, Telefone) VALUES 
('João Silva', 'Rua A, 123', '(11) 1111-2267'),
('Maria Oliveira', 'Rua B, 456', '(21) 3333-4154');

-- Inserindo dados na tabela Veiculo
INSERT INTO Veiculo (Placa, Modelo, Marca, Ano, idCliente) VALUES 
('ABC1D23', 'Civic', 'Honda', 2020, 1),
('XYZ4E56', 'Corolla', 'Toyota', 2018, 2);

-- Inserindo dados na tabela Equipe_Responsavel
INSERT INTO Equipe_Responsavel (NomeEquipe) VALUES 
('Equipe A'),
('Equipe B');

-- Inserindo dados na tabela Mecanico
INSERT INTO Mecanico (Nome, Endereco, Especialidade, idEquipe) VALUES 
('Carlos Santos', 'Rua C, 789', 'Motor', 1),
('Ana Paula', 'Rua D, 012', 'Freios', 2);

-- Inserindo dados na tabela Servico
INSERT INTO Servico (Descricao, ValorMaoDeObra) VALUES 
('Troca de óleo', 100.00),
('Alinhamento', 150.00),
('Balanceamento', 80.00);

-- Inserindo dados na tabela Ordem Servico
INSERT INTO Ordem_de_Servico (DataEmissao, Status, DataEntrega, PlacaVeiculo, idEquipe) VALUES 
('2024-08-10', 'Concluído', '2024-08-12', 'ABC1D23', 1),
('2024-08-11', 'Em Progresso', NULL, 'XYZ4E56', 2);

-- Inserindo dados na tabela Pecas
INSERT INTO Pecas (Nome, Quantidade, ValorUnitario) VALUES 
('Filtro de óleo', 50, 20.00),
('Pastilha de freio', 30, 150.00);

-- Inserindo dados na tabela Ordem Pecas
INSERT INTO Ordem_Pecas (idOrdem, idPeca, Quantidade) VALUES 
(1, 1, 2), 
(2, 2, 1); 

-- Inserindo dados na tabela Ordem Servico
INSERT INTO Ordem_Servico (idOrdem, idServico) VALUES 
(1, 1),
(2, 2), 
(2, 3); 

-- // Queries para consulta no banco de dados // --

-- Recuperações Simples com SELECT Statement:
SELECT * FROM Cliente;
SELECT * FROM Veiculo;

-- Quais clientes possuem veículos com ordens de serviço em progresso?
SELECT 
    DISTINCT c.Nome AS NomeCliente
FROM 
    Ordem_de_Servico o
JOIN 
    Veiculo v ON o.PlacaVeiculo = v.Placa
JOIN 
    Cliente c ON v.idCliente = c.idCliente
WHERE 
    o.Status = 'Em Progresso';

-- Qual é o valor total detalhado de cada ordem de serviço?
SELECT 
    o.idOrdem,
    SUM(s.ValorMaoDeObra) AS TotalMaoDeObra,
    SUM(p.Quantidade * p2.ValorUnitario) AS TotalPecas,
    (SUM(s.ValorMaoDeObra) + SUM(p.Quantidade * p2.ValorUnitario)) AS ValorTotal
FROM 
    Ordem_de_Servico o
LEFT JOIN 
    Ordem_Servico os ON o.idOrdem = os.idOrdem
LEFT JOIN 
    Servico s ON os.idServico = s.idServico
LEFT JOIN 
    Ordem_Pecas p ON o.idOrdem = p.idOrdem
LEFT JOIN 
    Pecas p2 ON p.idPeca = p2.idPeca
GROUP BY 
    o.idOrdem;

-- Quais ordens de serviço foram emitidas mais recentemente?
SELECT * FROM Ordem_de_Servico
ORDER BY DataEmissao DESC
LIMIT 5; -- Retorna as 5 ordens mais recentes

-- Qual equipe está responsável pelas ordens de serviço cujo valor total supera R$500,00?
SELECT 
    o.idOrdem,
    e.NomeEquipe,
    (SUM(s.ValorMaoDeObra) + SUM(p.Quantidade * p2.ValorUnitario)) AS ValorTotal
FROM 
    Ordem_de_Servico o
JOIN 
    Equipe_Responsavel e ON o.idEquipe = e.idEquipe
LEFT JOIN 
    Ordem_Servico os ON o.idOrdem = os.idOrdem
LEFT JOIN 
    Servico s ON os.idServico = s.idServico
LEFT JOIN 
    Ordem_Pecas p ON o.idOrdem = p.idOrdem
LEFT JOIN 
    Pecas p2 ON p.idPeca = p2.idPeca
GROUP BY 
    o.idOrdem
HAVING 
    ValorTotal > 500;




