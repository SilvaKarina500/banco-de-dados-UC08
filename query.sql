--07/05/2026
CREATE DATABASE  `contato_13`; 
-- CRIAÇÃO DO BANCO DE DADOS, DEVE USAR CRASE
USE `contato_13`;

create table `clientes`(
`id_cliente` int(4) unsigned not null auto_increment,
`nome` varchar(120) not null,
`email` varchar(150) not null,
`rua` varchar (200) not null,
`bairro` varchar(150) not null,
PRIMARY kEY (`id_cliente`)
)engine=InnoDB AUTO_INCREMENT=4 CHARSET=utf8 COLLATE=utf8_unicode_ci;

--inserindo dados pela primeira vez na tabela: 
INSERT INTO `clientes` (`id_cliente`,`nome`,`email`,`rua`,`bairro`)VALUES
(1,'João','joaosilva@gmail.com','Tito,54','LAPA'),
(2,'Pedro','pedrosilva@gmail.com','Tito,54','LAPA'),
(3,'Josefina','josefina@gmail.com','Tito,54','LAPA'),
(4,'Marcela','marcela@gmail.com','Tito,54','LAPA'),
(5,'Vitor','vitors@gmail.com','Tito,54','LAPA');

--para inserir dados sem o id: 
INSERT INTO `clientes` (`nome`,`email`,`rua`,`bairro`)VALUES
('João','joaosilva@gmail.com','Tito,54','LAPA'),
('Pedro','pedrosilva@gmail.com','Tito,54','LAPA'),
('Josefina','josefina@gmail.com','Tito,54','LAPA'),
('Marcela','marcela@gmail.com','Tito,54','LAPA'),
('Vitor','vitors@gmail.com','Tito,54','LAPA');

--para deletar os dados da tabela
truncate table `clientes`;

--seleção da tabela (tudo)
select * from `produtos`;

-- selecionar mais de uma tabela ao mesmo tempo 
select * from `produtos`, `colaboradores`; 

--selecionando nom e e-mail da tabela clientes
select nome, email from `clientes`;

--selecionando os produtos em ordem alfabetica
select produto from `produtos` order by produto asc;

--selecionando os produtos em ordem decrescente
select produto from `produtos` order by produto desc;
--selecionando o nome, email, cidade em ordem alfabetica pela cidade e nome
select nome, email, cidade from `clientes` order by cidade, nome;


--14/05
-- os 10 primeiros 
select id, nome, email from clientes LIMIT 10;

--10 ultimos cadastrados
select id, nome, email from clientes order by id desc limit 10;

--encomendas mais recentes 
select * from encomendas order by data_hora desc;
-- 15 itens a partir do id de numero 6
select id, nome, email from clientes LIMIT 15 offset 5;
-- 5 itens a partir do número 16
select id, nome, email from clientes LIMIT 15, 5;
-- produto mais caro
select * from produtos order by preco_unidade limit 1;
-- terceiro item  mais caro (aparecer dois itens)
select * from produtos order by preco_unidade desc limit 2,2;
-- DISTINC tira o que é duplucado. 
select DISTINCT preco_unidade FROM produtos order by preco_unidade;
-- WHERE - permite definir condições que identificam quais os registros que vão ser afetados pela query. 
-- SELECT - vai definir condições para devolver dados de acordop com a condição.

select * from clientes where cidade = "Lisboa";
--Trabalhar com comparativos lógicos:
select * from clientes where sexo = "F";
select * from clientes where cidade ="COIMBRA" AND sexo <> "F" ;
select * from produtos where preco_unidade > 1;
select * from produtos where preco_unidade <= 1.5; 
select * from produtos where preco_unidade >= 1 and preco_unidade <= 2;
select * from encomendas where data_hora <= "2030-01-02 10:00:00";
--betweem pode trazer entervalo de valores
select * from produtos where preco_unidade between 1 and 2;
--IN devolve todos os registros que estejam em uma coleção
select * from clientes where cidade IN ("Lisboa", "viseu", "coimbra");
-- OR irá selecionar um valor ou outro valor (se não tiver um ele tras o outro)
select * from clientes where cidade = "Lisboa" OR cidade = "Viseu";
--LIKE - é um operador que permite pesquisar no interior da célula
--% representa zero ou mais caracteres
-- _ (underline) representa um caracter apenas
select * from clientes where nome LIKE "João%";
select * from clientes where email LIKE "%gmail.com";
select * from clientes where nome LIKE "A%S";
select * from clientes where nome LIKE "Francisc_%";
select * from clientes where nome LIKE "__a%";
select * from clientes where data_nascimento LIKE "%2000%";
-- NULL - busca todos os dados nulos, caso houver.
select * from colaboradores where ativo IS not NULL;
--AS - Nome temporário
select produto AS FRUTA  from produtos;


--25/06/2026
USE loja_online;
SELECT  nome from colaboradores
union
-- organição das colunas (AS) cria as colunas o (union) seria para unir as tabelas (lembrando só vai puxar oque estiver na tava que esta chamando)
--O union - combina conjuntos de resultados de duas ou mais declarações em uma unica tabela (query)
--Para acrescentar as xolunas as duas tabelas precisam estarem com a mesma quantidade(colunas)
select produto from produtos;
SELECT "colaboradores" AS contexto, id, nome AS valor from colaboradores
union
select "produto" AS contexto, id, produto AS valor from produtos;

-- une tudo e duplica (union all)
SELECT nome from colaboradores
union all
select nome from colaboradores;

--Selecionar os primeiros 50 clientes e, se forem do sexo f, vêm identificado
--como feminino, e se for m, vÊm como masculino:
select
nome,
case(sexo)
when 'f' then 'feminino'
when 'm' then 'masculino'
end sexo
 from clientes limit 50;

--O case pode ser usado também para trazer dados e fazer uma comparação ao mesmo
--tempo, neste caso não preciso do parâmetro de comparação.
 select
nome, email,
case
when email LIKE "%@gmail.com" then 'GMAIL'
when email LIKE "%@hotmail.com" then 'HOTMAIL'
ELSE "..."
end DOMINIO 
 from clientes limit 50;

--Quero o nome dos colaboradores e saber quem está ativo ou
--inativo.
select
nome, 
case
when ativo LIKE "1" then 'ativo'
when ativo LIKE "0" then 'inativo'
end STATUS
from colaboradores;
-- para trazer uma tabela e trazer o
select
clientes.nome cliente,
colaboradores.nome colaboradores,
encomendas.data_hora
from encomendas
left join clientes
on encomendas.id_cliente = clientes.id
left join colaboradores
on encomendas.id_colaborador = colaboradores.id
where encomendas.id = 1;

-- Quero obter os dados completos de uma encomenda e saber quem é o cliente,
--colaborador, quando foi a encomenda, os produtos e as quantidades 
-- A Maria comprou do jose no dia 10/06/2026, 40 laranjas