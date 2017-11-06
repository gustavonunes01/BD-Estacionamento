create database estacionamento;

use estacionamento

create table funcionario(
	cod_func integer not null,
	nome varchar(60),
	data_nasc date,
	cpf varchar(10),
	rua varchar(30),
	nro integer,
	bairro varchar(20),
	cidade varchar(30),
	estado varchar(20),
	CEP varchar(9),
	primary key(cod_func));

create table cartao(
	cod_cartao integer not null,
	data_c date,
	nome_cliente varchar(60),
	CPF varchar(10),
	primary key(cod_cartao));

create table automovel(
	letra varchar(4) not null,
	numero integer not null,
	cidade varchar(15) not null,
	estado varchar(2) not null,
	tipo varchar(10),
	modelo varchar(15),
	ano integer,
	marca varchar(15),
	primary key(letra, numero, cidade, estado));

create table vaga(
	numero integer not null,
	tipo varchar(15),
	primary key(numero));

create table emp_seguranca(
	CNPJ varchar(14) not null,
	nome_emp varchar(60),
	rua varchar(30),
	nro integer,
	bairro varchar(20),
	cidade varchar(30),
	estado varchar(20),
	CEP varchar(9),
	primary key(CNPJ));

create table seguranca(
	cod_seg integer not null,
	nome varchar(60) not null,
	CPF varchar(10) not null,
	rua varchar(30),
	nro integer,
	bairro varchar(20),
	cidade varchar(30),
	estado varchar(20),
	CEP varchar(9),
	primary key(cod_seg));

create table telefone_funcionario(
	cod_fnc integer not null,
	telefone integer not null,
	primary key(cod_fnc, telefone),
	foreign key(cod_fnc) references funcionario(cod_func));

create table telefone_empresa_seguranca(
	localEMP varchar(14) not null,
	telefone integer not null,
	primary key(localEMP, telefone),
	foreign key(localEMP) references emp_seguranca(CNPJ));

create table manobrista(
	nroFUNCI integer not null, 
	num_cnh integer not null,
	primary key(nroFUNCI),
	foreign key(nroFUNCI) references funcionario(cod_func));

create table atendente(
	nroFUNCI integer not null, 
	curso_ADM varchar(60) not null,
	primary key(nroFUNCI),
	foreign key(nroFUNCI) references funcionario(cod_func));

create table vigia(
	cod_seg integer not null,
	pLetra varchar(4) not null,
	pNumero integer not null,
	pCidade varchar(15) not null,
	pEstado varchar(2) not null,
	primary key(cod_seg, pLetra, pNumero, pCidade, pEstado),
	foreign key(pLetra, pNumero, pCidade, pEstado) references automovel(letra, numero, cidade, estado),
	foreign key(cod_seg) references seguranca(cod_seg));
	
create table estaciona(
	pLetra varchar(4) not null,
	pNumero integer not null,
	pCidade varchar(15) not null,
	pEstado varchar(2) not null,
	cod_manobrista integer not null,
	num_vaga integer not null,
	primary key(pLetra, pNumero, pCidade, pEstado, cod_manobrista, num_vaga),
	foreign key(pLetra, pNumero, pCidade, pEstado) references automovel(letra, numero, cidade, estado),
	foreign key(cod_manobrista) references funcionario(cod_func),
	foreign key(num_vaga) references vaga(numero));

/* PARTE 2 b) Elaborar comandos de modificação de domínio de atributos (pelo menos 5 comandos)
 e inclusão de novos atributos (pelo menos 5 comandos) nas tabelas.*/
	
	alter table estaciona add EData date;
	alter table estaciona add hora_saida time;
	alter table estaciona add hora_entrada time;
	alter table estaciona add valor_hora integer;
	alter table estaciona add valor_total integer;
	alter table estaciona modify valor_hora float;
	alter table estaciona modify valor_total float;
	alter table funcionario modify cpf varchar(11);
	alter table cartao modify cpf varchar(11);
	alter table seguranca modify cpf varchar(11);
	alter table automovel modify modelo varchar(20);
	alter table manobrista modify num_cnh varchar(12);
	alter table emp_seguranca change nome_emp nome varchar(50);
	alter table cartao change cod_cartao cod integer not null;
	alter table telefone_funcionario modify telefone integer(12) not null;
	alter table seguranca add cnpj_emp varchar(14) not null;
	ALTER TABLE seguranca ADD FOREIGN KEY(cnpj_emp) REFERENCES emp_seguranca(CNPJ);

/*PARTE 3 Inserção Atualização e Remoção de dados nas tabelas */

--funcionario
	insert into funcionario values(01,'Arnaldo Cesar Coelho','1975-8-20',11209415399,'Rua Dona Alexandrina',790,'Centro','São Carlos','SP','13573773'); --Atendente;
	insert into funcionario values(02,'Edson Arantes','1985-1-15',97621272422,'Rua XV de Novembro',247,'Centro','São Carlos','SP','13573186');			--Manobrista;
	insert into funcionario values(03,'Jo Soares','1994-7-10',51457388979,'Av Padre Francisco Sales',831,'São Geraldo','Araraquara','SP','95088120');	--Manobrista;
	insert into funcionario values(04,'Dexter Morgan','1980-12-27',42878002652,'Rua José Malaquias',13,'Santa Felícia','São Carlos','SP','13555089');	--Manobrista;
	insert into funcionario values(05,'Scarlett Johansson','1984-6-25',95517165826,'Rua Urutau',796,'Residencial Damha','Araraquara','SP','14804453'); 	--Atendente;
--telefone_funcionario
	insert into telefone_funcionario values(01,1633747873);
	insert into telefone_funcionario values(02,1627891960);
	insert into telefone_funcionario values(03,1684306471);
	insert into telefone_funcionario values(04,1625342141);
	insert into telefone_funcionario values(05,1685365620);
--cartao
	insert into cartao values(112,'2016-8-23','Carlos Alberto de Nóbrega','47434689811');
	insert into cartao values(245,'2015-7-10','Zeca Pagodinho','89605545292');
	insert into cartao values(157,'2017-4-27','Dudu Nobre','17407840733');
	insert into cartao values(198,'2012-2-1','Fafá de Belém','86673397250');
	insert into cartao values(211,'2015-12-5','Celso Portiolli','76434966768');
--automovel
	insert into automovel values('EGQ',1733,'São Carlos','SP','Carro','A3 1.6',1999,'Audi');
	insert into automovel values('DWP',9377,'São Carlos','SP','Carro','GLX 1.6',2001,'Citroen');
	insert into automovel values('FQL',7052,'São Carlos','SP','Moto','CB 900 FHornet 919',2005,'Honda');
	insert into automovel values('CUP',6534,'Araraquara','SP','Carro','130iA 3.0',2008,'BMW');
	insert into automovel values('GJI',5540,'São Carlos','SP','Carro','X5 3.0',2015,'BMW');
--vaga
	insert into vaga values(100,'Carro');
	insert into vaga values(101,'Carro');
	insert into vaga values(102,'Carro');
	insert into vaga values(103,'Carro');
	insert into vaga values(104,'Carro');
	insert into vaga values(200,'Moto');
	insert into vaga values(201,'Moto');
	insert into vaga values(202,'Moto');
	insert into vaga values(203,'Moto');
	insert into vaga values(204,'Moto');
--emp_seguranca
	insert into emp_seguranca values(62899718000119, 'Secure Server', 'irineu', 1740, 'Caboclo', 'São Paulo', 'SP', 13563340);
	insert into emp_seguranca values(88684487000110, 'Geforce', 'Nvidia', 1, 'Cabo', 'São Paulo', 'SP', 13563250);
	insert into emp_seguranca values(27277769000108, 'Engecer', 'Vigarista', 2, 'Ca', 'São Paulo', 'SP', 26563340);
	insert into emp_seguranca values(53438254000152, 'MacTrump', 'Mexico', 3, 'hola', 'Aracaju', 'BH', 49008067);
	insert into emp_seguranca values(49872814000105, 'Secure 157', 'Ladrao', 157, 'Catatau', 'São Paulo', 'SP', 33565341);	
--seguranca
	insert into seguranca values(1, 'Sergio Abreu', 45750819906, 'Albano', 11, 'Sandro', 'Aracaju', 'BH', 49008066, 62899718000119);
	insert into seguranca values(2, 'Gustavo Henrique', 46760818806, 'Albino triques', 1740, 'Santa felicia', 'São Carlos', 'SP', 13563340, 88684487000110);
	insert into seguranca values(3, 'Carlos Silvao', 67798262350, 'Truco', 666, 'Seis Ladrao', 'São Carlos', 'SP', 15563340, 53438254000152);
	insert into seguranca values(4, 'Rafael Bono', 55223792009, 'IFUDEU', 10, 'IFSP', 'São Carlos', 'SP', 13565905, 27277769000108);
	insert into seguranca values(5, 'Thiago Nunes', 60361429517, 'Albino triques', 1740, 'Santa felicia', 'São Carlos', 'SP', 13563340, 49872814000105);
--telefone_empresa_seguranca
	insert into telefone_empresa_seguranca values(62899718000119, 1134151350);
	insert into telefone_empresa_seguranca values(88684487000110, 1133031577);
	insert into telefone_empresa_seguranca values(27277769000108, 1130315111);
	insert into telefone_empresa_seguranca values(53438254000152, 754566794);
	insert into telefone_empresa_seguranca values(49872814000105, 1155064788);
--manobrista
	insert into manobrista values(02,'49375919991');
	insert into manobrista values(03,'83744722738');
	insert into manobrista values(04,'96770310480');
--atendente
	insert into atendente values(01,'Adm Financeira, Orçamentária e Contábil');
	insert into atendente values(05,'Adm Financeira');
--vigia
	insert into vigia values(1 ,'EGQ',1733,'São Carlos','SP');
	insert into vigia values(2 ,'DWP',9377,'São Carlos','SP');
	insert into vigia values(3 ,'FQL',7052,'São Carlos','SP');
	insert into vigia values(4 ,'CUP',6534,'Araraquara','SP');
	insert into vigia values(5 ,'GJI',5540,'São Carlos','SP');
--estaciona 
	insert into estaciona values('GJI',5540,'São Carlos','SP',03,100,'2017-5-11','12:00','14:30',12,18);
	insert into estaciona values('CUP',6534,'Araraquara','SP',02,101,'2016-9-1','08:30','12:30',12,48);
	insert into estaciona values('FQL',7052,'São Carlos','SP',04,201,'2015-12-24','10:00','11:45',10,27.5);
	insert into estaciona values('EGQ',1733,'São Carlos','SP',04,102,'2015-11-1','14:30','18:30',10,40);
	insert into estaciona values('DWP',9377,'São Carlos','SP',03,103,'2017-2-15','13:45','15:45',12,24);

-- INICIO DOS SELECTS

-- Consulta de todos os Automóveis(aprentados como tipo e modelo) vigiados pelo seguranca de código 1 e sua respectiva Empresa de Segurança.
4.1 select	E.nome,E.cidade,E.estado,S.cod_seg,S.nome,A.tipo,A.modelo from emp_seguranca E, seguranca S, automovel A, vigia V 
		where V.cod_seg=S.cod_seg and V.pLetra=A.letra and V.pNumero=A.numero and V.pCidade=A.cidade and V.pEstado=A.estado and S.cnpj_emp=E.CNPJ and S.cod_seg=1;


-- Consulta de hora de entrada em uma vaga e valor total pago(o menor).
4.2 select VA.numero as Numero_da_Vaga, ES.hora_entrada, CONCAT(ES.pLetra,'-', ES.pNumero,' ','(', ES.pCidade,'-', ES.pEstado,')') as Placa_Veiculo ,ES.valor_total, F.nome as Manobrista 
		from vaga VA, estaciona ES, funcionario F 
			where VA.numero=ES.num_vaga and F.cod_func=ES.cod_manobrista and ES.valor_total=(select min(valor_total) from estaciona);

select ES.valor_total, VA.numero as Numero_da_Vaga, ES.hora_entrada, CONCAT(ES.pLetra,'-', ES.pNumero,' ','(', ES.pCidade,'-', ES.pEstado,')') as Placa_Veiculo , F.nome
from vaga VA right join estaciona ES on VA.numero=ES.num_vaga right join funcionario F on F.cod_func=ES.cod_manobrista where ES.valor_total IS NOT NULL;

-- Consulta todas as vagas que não seja de carro e que esteja estacionada.
4.3 select VA.numero, CONCAT(ES.pLetra,'-', ES.pNumero,' ','(', ES.pCidade,'-', ES.pEstado,')') as Placa_Veiculo, VA.tipo from vaga VA, estaciona ES
		where VA.numero=ES.num_vaga and VA.tipo NOT IN (select tipo from vaga where tipo='Carro');

-- Consulta todas os automoveis que foram estacionados as 12:00hr.
4.4 select VA.tipo, ES.hora_entrada, CONCAT(ES.pLetra,'-', ES.pNumero,' ','(', ES.pCidade,'-', ES.pEstado,')') as Placa_Veiculo from vaga VA, estaciona ES
		where VA.numero=ES.num_vaga and ES.hora_entrada = ANY (select hora_entrada from estaciona where hora_entrada LIKE '%12%');

-- Consulta todos os funcionarios que nasceram em 1985 pra frente.
4.5 select nome, data_nasc as Data_De_Nacimento from funcionario where data_nasc >= ALL (select data_nasc from funcionario where data_nasc like '%1985%');

-- Consulta para contar quantos automoveis tipo carro estão cadastrados.
4.6 select count(tipo) as Total_de_Carro from automovel where tipo like '%Carro%';

-- Consulta da soma do valor total da tabela estaciona.
4.7 select sum(valor_total) as Somado_do_Valor_Total from estaciona;

-- Consulta da media do valor total da tabela estaciona.
4.8 select AVG(valor_total) as Media_do_Valor_Total from estaciona;

-- Consulta de maior valor total da tabela estaciona.
4.9 select max(valor_total) as Maior_Valor_Total from estaciona;

-- Consulta de menor valor total da tabela estaciona.
4.10 select min(valor_total) as Menor_Valor_Total from estaciona;

-- Consulta de Nome e CNH de funcionario que é manobrista
4.11 select F.nome, M.num_cnh from funcionario F inner join manobrista M on F.cod_func=M.nroFUNCI;

-- Consulta de Nome de todos os funcionarios que é atendente até de quem não é.
4.12 select F.nome, A.curso_ADM from funcionario F left join atendente A on F.cod_func=A.nroFUNCI;

-- Consulta de Nome de todos os funcionarios que é manobrista até de quem não é.
4.13 select F.nome, M.num_cnh from manobrista M right join funcionario F on F.cod_func=M.nroFUNCI;


select * from funcionario where data_nasc like '%1985%' or data_nasc in ('1994-07-10', '1975-08-20');