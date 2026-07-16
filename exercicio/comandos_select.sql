-- Scripts SQL com base no modelo de DDL fornecido

-- 1. Listar todos os dados de todas as pessoas cadastradas.
SELECT *
FROM PESSOA;

-- 2. Listar nome, e-mail e data de nascimento das pessoas cadastradas.
SELECT nome, email, data_nasc
FROM PESSOA;

-- 3. Listar nome, e-mail e data de nascimento da 3a à 8a pessoa cadastrada.
SELECT nome, email, data_nasc
FROM PESSOA
ORDER BY cpf
LIMIT 6 OFFSET 2;

-- 4. Listar nome, e-mail e idade das pessoas cadastradas.
SELECT nome, email, EXTRACT(YEAR FROM AGE(CURRENT_DATE, data_nasc)) AS idade
FROM PESSOA;

-- 5. Listar a quantidade de agendamentos.
SELECT COUNT(*) AS quantidade_agendamentos
FROM AGENDAMENTO;

-- 6. Listar a data/hora das consultas e os respectivos valores com desconto de 5%. Os valores devem ser precedidos com "R$".
SELECT dh_consulta,
       CONCAT('R$ ', TO_CHAR(valor_consulta * 0.95, 'FM9999990.00')) AS valor_com_desconto
FROM AGENDAMENTO;

-- 8. Listar os dados dos agendamentos registrados para o mesmo mês da consulta.
SELECT a.*
FROM AGENDAMENTO a
WHERE EXTRACT(MONTH FROM a.dh_agendamento) = EXTRACT(MONTH FROM a.dh_consulta)
  AND EXTRACT(YEAR FROM a.dh_agendamento) = EXTRACT(YEAR FROM a.dh_consulta);

-- 10. Listar a data das consultas cujo o valor está entre R$ 50.00 e R$ 100.00.
SELECT CAST(dh_consulta AS DATE) AS data_consulta
FROM AGENDAMENTO
WHERE valor_consulta BETWEEN 50.00 AND 100.00;

-- 13. Listar a quantidade de pacientes que não possuem plano de saúde.
SELECT COUNT(*) AS quantidade_pacientes_sem_plano
FROM PACIENTE
WHERE plano_saude = FALSE;

-- 14. Listar o maior e o menor valor das consultas agendadas para cada dia que contém consulta.
SELECT CAST(dh_consulta AS DATE) AS data_consulta,
       MAX(valor_consulta) AS maior_valor,
       MIN(valor_consulta) AS menor_valor
FROM AGENDAMENTO
GROUP BY CAST(dh_consulta AS DATE)
ORDER BY data_consulta;

-- 15. Listar a média dos valores das consultas agendadas para o mês de Dezembro.
SELECT AVG(valor_consulta) AS media_valor_consultas_dezembro
FROM AGENDAMENTO
WHERE EXTRACT(MONTH FROM dh_consulta) = 12;