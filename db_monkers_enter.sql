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
data_de_cadastro datetime not null, 
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