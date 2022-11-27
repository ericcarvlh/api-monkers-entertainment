create database db_monkers_enter
default character set utf8
default collate utf8_general_ci;

use db_monkers_enter;

CREATE TABLE tbl_Uf (
cd_uf int PRIMARY KEY auto_increment,
nm_uf varchar(40) not null
) default charset utf8;

CREATE TABLE tbl_Cidade (
cd_cidade int PRIMARY KEY auto_increment,
nm_cidade varchar(40) not null,
cd_uf int not null,
Constraint FOREIGN KEY(cd_uf) REFERENCES tbl_Uf (cd_uf)
) default charset utf8;

CREATE TABLE tbl_Endereco (
cd_endereco int PRIMARY KEY auto_increment,
logradouro_endereco varchar(60) not null,
cep_endereco char(8) not null,
complemento_endereco varchar(60) null,
bairro_endereco varchar(40) not null,
numero_endereco varchar(6) not null,
cd_cidade int not null,
Constraint FOREIGN KEY(cd_cidade) REFERENCES tbl_Cidade (cd_cidade)
) default charset utf8;

CREATE TABLE tbl_Franquia (
cd_franquia int PRIMARY KEY auto_increment,
nm_franquia varchar(40) not null
) default charset utf8;

CREATE TABLE tbl_Cinema (
cd_cinema int PRIMARY KEY auto_increment,
nm_cinema varchar(60) not null,
cd_franquia int not null,
cd_endereco int not null,
Constraint FOREIGN KEY(cd_franquia) REFERENCES tbl_Franquia (cd_franquia),
Constraint FOREIGN KEY(cd_endereco) REFERENCES tbl_Endereco (cd_endereco)
) default charset utf8;

CREATE TABLE tbl_Ingresso (
cd_ingresso int PRIMARY KEY auto_increment,
valor_servico decimal(10,2) not null,
preco_inteira decimal(10,2) not null,
cd_filme int not null, 
Constraint FOREIGN KEY(cd_filme) REFERENCES tbl_Cinema(cd_cinema)
) default charset utf8;

CREATE TABLE tbl_Filme (
cd_filme int PRIMARY KEY auto_increment,
nm_filme varchar(60) not null
) default charset utf8;

CREATE TABLE tbl_Tipo_Entreterimento(
cd_entreterimento int PRIMARY KEY auto_increment,
nm_entreterimento varchar(40) not null 
) default charset utf8;

CREATE TABLE tbl_Genero (
cd_genero int PRIMARY KEY auto_increment,
nm_genero varchar(60) not null
) default charset utf8;

CREATE TABLE tbl_Entreterimento_Genero (
cd_entreterimento int not null,
cd_genero int not null, 
Constraint FOREIGN KEY(cd_entreterimento) REFERENCES tbl_Tipo_Entreterimento (cd_entreterimento),
Constraint FOREIGN KEY(cd_genero) REFERENCES tbl_Genero (cd_genero),
Constraint PRIMARY KEY(cd_entreterimento, cd_genero)
) default charset utf8;

CREATE TABLE tbl_Categoria_Personalidade (
cd_categoria int PRIMARY KEY auto_increment,
nm_categoria_personalidade varchar(60) not null
) default charset utf8;

CREATE TABLE tbl_Personalidade (
cd_personalidade int PRIMARY KEY auto_increment,
nm_personalidade  varchar(60) not null,
sigla_personalidade varchar(60) not null,
cd_categoria int not null,
Constraint FOREIGN KEY(cd_categoria) REFERENCES tbl_Categoria_Personalidade (cd_categoria)
) default charset utf8;

CREATE TABLE tbl_Foto_Perfil (
cd_foto_perfil int PRIMARY KEY auto_increment,
url_foto_perfil varchar(255) not null
) default charset utf8;

CREATE TABLE tbl_Usuario (
cd_usuario int PRIMARY KEY auto_increment,
nome_usuario varchar(90) UNIQUE not null,
data_de_nascimento date null,
email_usuario varchar(90) UNIQUE not null,
senha_usuario varchar(15) not null,
cd_personalidade int null,
cd_foto_perfil int not null,
Constraint FOREIGN KEY(cd_personalidade) REFERENCES tbl_Personalidade (cd_personalidade),
Constraint FOREIGN KEY(cd_foto_perfil) REFERENCES tbl_Foto_Perfil (cd_foto_perfil)
) default charset utf8;

CREATE TABLE tbl_Genero_Categoria_Personalidade (
cd_genero int not null,
cd_categoria int not null,
Constraint FOREIGN KEY(cd_genero) REFERENCES tbl_Genero (cd_genero),
Constraint FOREIGN KEY(cd_categoria) REFERENCES tbl_Categoria_Personalidade (cd_categoria),
Constraint PRIMARY KEY(cd_genero, cd_categoria)
) default charset utf8;

CREATE TABLE tbl_Ingresso_Cinema (
cd_cinema int not null,
cd_ingresso int not null,
Constraint FOREIGN KEY(cd_cinema) REFERENCES tbl_Cinema (cd_cinema),
Constraint FOREIGN KEY(cd_ingresso) REFERENCES tbl_Ingresso (cd_ingresso),
Constraint PRIMARY KEY(cd_cinema, cd_ingresso)
) default charset utf8;

create view vw_consultaDadosLogin
	as
	select
	usu.cd_usuario,
	usu.nome_usuario,
    usu.data_de_nascimento,
	usu.email_usuario,
	usu.senha_usuario,
    usu.cd_personalidade,
	ft.cd_foto_perfil,
	ft.url_foto_perfil
	from tbl_Usuario as usu inner join tbl_Foto_Perfil as ft
	on usu.cd_foto_perfil = ft.cd_foto_perfil;

drop procedure if exists sp_consultaDadosLogin_Com_Email_E_Senha;
	delimiter $$
create procedure sp_consultaDadosLogin_Com_Email_E_Senha
	(
		in vEmail_usuario varchar(90),
		in vSenha_usuarioint varchar(15)
	)
	begin
		select * from vw_consultaDadosLogin 
        where email_usuario = vEmail_usuario
        and senha_usuario = vSenha_usuarioint;
	end $$
		delimiter ;

drop procedure if exists sp_consultaDadosLogin_Com_Usuario_E_Senha;
	delimiter $$
create procedure sp_consultaDadosLogin_Com_Usuario_E_Senha
	(
		in vNome_usuario varchar(90),
		in vSenha_usuarioint varchar(15)
	)
	begin
		select * from vw_consultaDadosLogin 
        where nome_usuario = vNome_usuario
        and senha_usuario = vSenha_usuarioint;
	end $$
		delimiter ;

create view vw_consultaPersonalidades
	as
	select
	per.cd_personalidade,
	per.nm_personalidade,
	per.sigla_personalidade,
	cat.cd_categoria,
	cat.nm_categoria_personalidade
	from tbl_Personalidade as per inner join tbl_Categoria_Personalidade as cat
	on per.cd_categoria = cat.cd_categoria
    order by nm_personalidade;

Insert into tbl_Foto_Perfil values
(1, 'https://cdn.discordapp.com/attachments/1016110803641970698/1044997956731944980/monkeyyssluffy.png'),
(2, 'https://cdn.discordapp.com/attachments/1016110803641970698/1044997957247848519/monkeyysscoringa-removebg-preview.png'),
(3, 'https://cdn.discordapp.com/attachments/1016110803641970698/1044997957780512839/monkeyysseapol-removebg-preview.png'),
(4, 'https://cdn.discordapp.com/attachments/1016110803641970698/1044997958204145784/monkeyyssterror-removebg-preview.png'),
(5, 'https://cdn.discordapp.com/attachments/1016110803641970698/1044997958623567912/MONKRED.png');

Insert into tbl_Usuario (cd_usuario, nome_usuario, email_usuario, senha_usuario, cd_foto_perfil) values 
(default, 'dogorBolaEsquerda', 'dogorberserk@gmail.com', 'souCriminoso', 4),
(default, 'Raur', 'raur@gmail.com', 'ruarEstranho', 2),
(default, 'nanaca', 'nanadorau@gmail.com', 'rauzinho123', 5),
(default, 'tonyto', 'ehotom@gmail.com', 'ster321', 3),
(default, 'ercio', 'erico@gmail.com', 'euamovcs123', 1);

Insert into tbl_Categoria_Personalidade values 
(1, 'Diplomatas'),
(2, 'Analistas'),
(3, 'Exploradores'),
(4, 'Sentinelas');

/* Analistas */
Insert into tbl_Personalidade values 
(default, 'Arquiteto', 'INTJ', 2),
(default, 'Lógico', 'INTP', 2),
(default, 'Comandante', 'ENTJ', 2),
(default, 'Inovador', 'ENTP', 2);

/* Diplomatas */
Insert into tbl_Personalidade values 
(default, 'Advogado', 'INFJ', 1),
(default, 'Mediador', 'INFP', 1),
(default, 'Protagonista', 'ENFJ', 1),
(default, 'Ativista', 'ENTP', 1);

/* Sentinelas */
Insert into tbl_Personalidade values 
(default, 'Logístico', 'ISTJ', 4),
(default, 'Defensor', 'ISFJ', 4),
(default, 'Executivo', 'ESTJ', 4),
(default, 'Cônsul', 'ENTP', 4);

/* Exploradores */
Insert into tbl_Personalidade values 
(default, 'Virtuoso', 'ISTP', 3),
(default, 'Aventureiro', 'ISFP', 3),
(default, 'Empresário', 'ESTP', 3),
(default, 'Animador', 'ESFP', 3);

Insert into tbl_Tipo_Entreterimento values
(1, 'Movie'),
(2, 'Tv');

/* Movie */
Insert into tbl_Genero values 
(28, 'Ação'), (12, 'Aventura'), (16, 'Animação'), (35, 'Comédia'),
(80, 'Crime'), (99, 'Documentário'), (18, 'Drama'), (10751, 'Família'),
(14, 'Fantasia'), (36, 'História'), (27, 'Terror'), (10402, 'Música'),
(9648, 'Mistério'), (10749, 'Romance'), (878, 'Ficção científica'), (10770, 'Cinema TV'),
(53, 'Suspense'), (10752, 'Guerra'), (37, 'Faroeste');

/* Tv */
Insert into tbl_Genero values 
(10759, 'Ação e Aventura'), (10762, 'Kids'), (10763, 'News'), (10764, 'Reality'), 
(10765, 'Ficção científica e Fantasia'), (10766, 'Soap'), (10767, 'Talk'), (10768, 'Guerra e Política');

/* Movie */
Insert into tbl_Entreterimento_Genero values 
(1, 28), (1, 12), (1, 16), (1, 35),
(1, 80), (1, 99), (1, 18), (1, 10751),
(1, 14), (1, 36), (1, 27), (1, 10402),
(1, 9648), (1, 10749), (1, 878), (1, 10770),
(1, 53), (1, 10752), (1, 37); 

/* Tv */
Insert into tbl_Entreterimento_Genero values 
(2, 10759), (2, 16), (2, 35), (2, 80), 
(2, 99), (2, 18), (2, 10751), (2, 10762), 
(2, 9648), (2, 10763), (2, 10764), (2, 10765), 
(2, 10766), (2, 10767), (2, 10768), (2, 37);

create view vw_consultaDadosGeneros
	as
	select
	gen.nm_genero as 'Gênero',
	tip.nm_entreterimento as 'Tipo de entreterimento',
	gen.cd_genero as 'Código do gênero',
	tip.cd_entreterimento as 'Código do entreterimento'
	from tbl_Genero as gen inner join tbl_Entreterimento_Genero as ent_gen
	on gen.cd_genero = ent_gen.cd_genero
    inner join tbl_Tipo_Entreterimento as tip
    on ent_gen.cd_entreterimento = tip.cd_entreterimento;

Insert into tbl_Genero_Categoria_Personalidade values
(16, 1), (10759, 1), 
(10770, 1), (80, 1);

create view vw_consultaDadosCategoriaPersonalidade
	as
	select
    tip.nm_entreterimento,
	gen.nm_genero as 'Gênero',
	cat_per.nm_categoria_personalidade as 'Categoria da personalidade',
	cat_per.cd_categoria as 'Código da categoria da personalidade',
	gen.cd_genero as 'Código do gênero',
    tip.cd_entreterimento
	from tbl_Categoria_Personalidade as cat_per inner join tbl_Genero_Categoria_Personalidade as gen_cat_per
    on cat_per.cd_categoria = gen_cat_per.cd_categoria
    inner join tbl_Genero as gen
    on gen_cat_per.cd_genero = gen.cd_genero
    inner join tbl_Entreterimento_Genero as ent_gen
    on gen.cd_genero = ent_gen.cd_genero
    inner join tbl_Tipo_entreterimento as tip
    on ent_gen.cd_entreterimento = tip.cd_entreterimento;
    
create view vw_consultaDadosUsuario
	as
	select
	usu.cd_usuario,
	usu.nome_usuario,
    usu.data_de_nascimento,
	usu.email_usuario,
	usu.senha_usuario,
	ft.cd_foto_perfil,
	ft.url_foto_perfil
	from tbl_Usuario as usu inner join tbl_Foto_Perfil as ft
	on usu.cd_foto_perfil = ft.cd_foto_perfil;

drop procedure if exists sp_consultaDadosUsuarioPorId;
	delimiter $$
create procedure sp_consultaDadosUsuarioPorId
	(
		in vCd_usuario int
	)
	begin
		select * from vw_consultaDadosUsuario 
        where cd_usuario = vCd_usuario;
	end $$
		delimiter ;

drop procedure if exists sp_atualizaDadosUsuario;
	delimiter $$
create procedure sp_atualizaDadosUsuario
	(
		in vCd_usuario int,
		in vNome_usuario varchar(90),
		in vData_de_nascimento date, 
		in vEmail_usuario varchar(90),
		in vSenha_usuario varchar(15), 
		in vCd_personalidade int, 
		in vCd_foto_perfil int
	)
	begin
		update tbl_Usuario
		set nome_usuario = vNome_usuario,
		data_de_nascimento = vData_de_nascimento,
		email_usuario = vEmail_usuario,
		senha_usuario = vSenha_usuario,
		cd_personalidade = vCd_personalidade,
		cd_foto_perfil = vCd_foto_perfil
		where cd_usuario = vCd_usuario;
	end $$
		delimiter ;
        
call sp_atualizaDadosUsuario(1, 'dogorBolaEsquerda', NULL, 'dogorberserk@gmail.com', 'souCriminoso', NULL, 4);
select * from tbl_Usuario;
/*
call sp_consultaDadosUsuarioPorId(1);
select * from tbl_Tipo_Entreterimento;
select * from tbl_Entreterimento_Genero;
select * from tbl_Genero;
select * from tbl_Categoria_Personalidade;
select * from vw_consultaPersonalidades;
*/