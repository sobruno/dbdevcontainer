CREATE TABLE PESSOA (
    cpf CHAR(11) NOT NULL,
    email VARCHAR(50) NOT NULL,
    nome VARCHAR(150) NOT NULL,
    data_nasc DATE NOT NULL,
    endereco VARCHAR(300) NOT NULL,
    telefone VARCHAR(15) NULL,
    
    CONSTRAINT pk_pessoa PRIMARY KEY (cpf),
    CONSTRAINT unique_email UNIQUE (email)
);

CREATE TABLE PACIENTE (
    codigo INT NOT NULL, 
    cpf_pessoa CHAR(11) NOT NULL,
    senha VARCHAR(10) NOT NULL,
    plano_saude BOOLEAN NOT NULL DEFAULT FALSE,
    
    CONSTRAINT pk_paciente PRIMARY KEY (codigo),
    CONSTRAINT unique_cpf_paciente UNIQUE (cpf_pessoa),
    CONSTRAINT fk_pessoa_paciente 
        FOREIGN KEY (cpf_pessoa) REFERENCES PESSOA(cpf),

    CONSTRAINT check_senha_tamanho 
        CHECK (LENGTH(senha) BETWEEN 5 AND 10)
);

CREATE TABLE MEDICO (
    crm VARCHAR(10) NOT NULL,
    cpf_pessoa CHAR(11) NOT NULL,
    
    CONSTRAINT pk_medico PRIMARY KEY (crm),
    CONSTRAINT unique_cpf_medico UNIQUE (cpf_pessoa),
    CONSTRAINT fk_pessoa_medico 
        FOREIGN KEY (cpf_pessoa) REFERENCES PESSOA(cpf)
);

CREATE TABLE ESPECIALIDADE (
    id INT NOT NULL,
    descricao VARCHAR(300) NOT NULL,
    
    CONSTRAINT pk_especialidade PRIMARY KEY (id)
);

CREATE TABLE MEDICO_ESPECIALIDADE (
    crm_medico VARCHAR(10) NOT NULL,
    id_especialidade INT NOT NULL,
    
    CONSTRAINT pk_medico_especialidade 
        PRIMARY KEY (crm_medico, id_especialidade),
    CONSTRAINT fk_medico_esp 
        FOREIGN KEY (crm_medico) REFERENCES MEDICO(crm),
    CONSTRAINT fk_especialidade_med 
        FOREIGN KEY (id_especialidade) REFERENCES ESPECIALIDADE(id)
);

CREATE TABLE AGENDAMENTO (
    codigo_paciente INT NOT NULL,
    crm_medico VARCHAR(10) NOT NULL,
    dh_consulta TIMESTAMP NOT NULL,
    dh_agendamento TIMESTAMP NOT NULL,
    valor_consulta DECIMAL(10, 2) NOT NULL DEFAULT 0.00,
    

    CONSTRAINT pk_agendamento 
        PRIMARY KEY (codigo_paciente, crm_medico, dh_consulta),
    

    CONSTRAINT fk_agendamento_paciente 
        FOREIGN KEY (codigo_paciente) REFERENCES PACIENTE(codigo),
    CONSTRAINT fk_agendamento_medico 
        FOREIGN KEY (crm_medico) REFERENCES MEDICO(crm)
);