
-- 7. Listar nome, cpf e e-mail dos pacientes que não possuem plano de saúde.
SELECT p.nome, p.cpf, p.email
FROM PESSOA p
JOIN PACIENTE pa ON p.cpf = pa.cpf_pessoa
WHERE pa.plano_saude = FALSE;

-- 9. Listar cpf, nome e e-mail dos pacientes que não possuem telefone.
SELECT p.cpf, p.nome, p.email
FROM PESSOA p
JOIN PACIENTE pa ON p.cpf = pa.cpf_pessoa
WHERE p.telefone IS NULL OR p.telefone = '';

-- 11. Listar cpf, nome e e-mail dos pacientes que moram em "Natal".
SELECT p.cpf, p.nome, p.email
FROM PESSOA p
JOIN PACIENTE pa ON p.cpf = pa.cpf_pessoa
WHERE LOWER(p.endereco) LIKE '%natal%';

-- 12. Listar cpf, nome, e-mail e data de nascimento dos pacientes ordenados pela data de nascimento.
SELECT p.cpf, p.nome, p.email, p.data_nasc
FROM PESSOA p
JOIN PACIENTE pa ON p.cpf = pa.cpf_pessoa
ORDER BY p.data_nasc;

-- 16. Listar nome e e-mail das pessoas que agendaram alguma consulta para o dia do seu aniversário.
SELECT DISTINCT p.nome, p.email
FROM PESSOA p
JOIN PACIENTE pa ON p.cpf = pa.cpf_pessoa
JOIN AGENDAMENTO a ON pa.codigo = a.codigo_paciente
WHERE EXTRACT(DAY FROM p.data_nasc) = EXTRACT(DAY FROM a.dh_consulta)
  AND EXTRACT(MONTH FROM p.data_nasc) = EXTRACT(MONTH FROM a.dh_consulta);

-- 17. Listar o nome, e-mail, cpf dos médicos e as suas respectivas especialidades.
SELECT p.nome, p.email, p.cpf, e.descricao AS especialidade
FROM PESSOA p
JOIN MEDICO m ON p.cpf = m.cpf_pessoa
JOIN MEDICO_ESPECIALIDADE me ON m.crm = me.crm_medico
JOIN ESPECIALIDADE e ON me.id_especialidade = e.id;

-- 18. Listar a quantidade de consultas para cada médico.
SELECT m.crm, p.nome AS nome_medico, COUNT(*) AS quantidade_consultas
FROM AGENDAMENTO a
JOIN MEDICO m ON a.crm_medico = m.crm
JOIN PESSOA p ON m.cpf_pessoa = p.cpf
GROUP BY m.crm, p.nome
ORDER BY quantidade_consultas DESC, p.nome;