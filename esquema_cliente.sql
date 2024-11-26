-- Tabela de Cliente
CREATE TABLE Cliente (
    ID_Cliente INT PRIMARY KEY,
    Nome VARCHAR(100),
    Endereco VARCHAR(255)
);

-- Tabela de Veículo
CREATE TABLE Veiculo (
    ID_Veiculo INT PRIMARY KEY,
    Modelo VARCHAR(100),
    Placa VARCHAR(20),
    Ano INT,
    ID_Cliente INT,
    FOREIGN KEY (ID_Cliente) REFERENCES Cliente(ID_Cliente)
);

-- Tabela de Equipe
CREATE TABLE Equipe (
    ID_Equipe INT PRIMARY KEY,
    Nome_Equipe VARCHAR(100)
);

-- Tabela de Mecânico
CREATE TABLE Mecanico (
    ID_Mecanico INT PRIMARY KEY,
    Nome VARCHAR(100),
    Endereco VARCHAR(255),
    Especialidade VARCHAR(100),
    ID_Equipe INT,
    FOREIGN KEY (ID_Equipe) REFERENCES Equipe(ID_Equipe)
);

-- Tabela de Ordem de Serviço (OS)
CREATE TABLE OrdemServico (
    N_OS INT PRIMARY KEY,
    Data_Emissao DATE,
    Valor_Total DECIMAL(10, 2),
    Status VARCHAR(50),
    Data_Conclusao DATE,
    ID_Veiculo INT,
    FOREIGN KEY (ID_Veiculo) REFERENCES Veiculo(ID_Veiculo)
);

-- Tabela de Serviço
CREATE TABLE Servico (
    ID_Servico INT PRIMARY KEY,
    Descricao VARCHAR(255),
    Valor DECIMAL(10, 2)
);

-- Tabela de Tabela de Mão-de-Obra
CREATE TABLE Tabela_MaoDeObra (
    ID_Tabela INT PRIMARY KEY,
    Tipo_Servico VARCHAR(100),
    Valor_Hora DECIMAL(10, 2)
);

-- Relacionamento entre Mecânico e Serviço (M:N)
CREATE TABLE Mecanico_Servico (
    ID_Mecanico INT,
    ID_Servico INT,
    PRIMARY KEY (ID_Mecanico, ID_Servico),
    FOREIGN KEY (ID_Mecanico) REFERENCES Mecanico(ID_Mecanico),
    FOREIGN KEY (ID_Servico) REFERENCES Servico(ID_Servico)
);

-- Relacionamento entre Ordem de Serviço e Serviço (1:N)
CREATE TABLE OrdemServico_Servico (
    N_OS INT,
    ID_Servico INT,
    PRIMARY KEY (N_OS, ID_Servico),
    FOREIGN KEY (N_OS) REFERENCES OrdemServico(N_OS),
    FOREIGN KEY (ID_Servico) REFERENCES Servico(ID_Servico)
);

-- Relacionamento entre Ordem de Serviço e Peça (M:N)
CREATE TABLE OrdemServico_Peca (
    N_OS INT,
    ID_Peca INT,
    PRIMARY KEY (N_OS, ID_Peca),
    FOREIGN KEY (N_OS) REFERENCES OrdemServico(N_OS),
    FOREIGN KEY (ID_Peca) REFERENCES Peca(ID_Peca)
);

-- Tabela de Peça
CREATE TABLE Peca (
    ID_Peca INT PRIMARY KEY,
    Nome VARCHAR(100),
    Valor DECIMAL(10, 2)
);

-- Relacionamento entre Tabela de Mão-de-Obra e Serviço (1:N)
CREATE TABLE Tabela_MaoDeObra_Servico (
    ID_Tabela INT,
    ID_Servico INT,
    PRIMARY KEY (ID_Tabela, ID_Servico),
    FOREIGN KEY (ID_Tabela) REFERENCES Tabela_MaoDeObra(ID_Tabela),
    FOREIGN KEY (ID_Servico) REFERENCES Servico(ID_Servico)
);
