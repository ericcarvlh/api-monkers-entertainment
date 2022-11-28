use db_monkers_enter;

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

create view vw_consultaDadosGeneros
	as
	select
	gen.nm_genero,
	tip.nm_entreterimento,
	gen.cd_genero,
	tip.cd_entreterimento
	from tbl_Genero as gen inner join tbl_Entreterimento_Genero as ent_gen
	on gen.cd_genero = ent_gen.cd_genero
    inner join tbl_Tipo_Entreterimento as tip
    on ent_gen.cd_entreterimento = tip.cd_entreterimento;

create view vw_consultaDadosCategoriaPersonalidade
	as
	select
    tip.nm_entreterimento,
	gen.nm_genero,
	cat_per.nm_categoria_personalidade,
	cat_per.cd_categoria,
	gen.cd_genero,
    tip.cd_entreterimento
	from tbl_Categoria_Personalidade as cat_per inner join tbl_Genero_Categoria_Personalidade as gen_cat_per
    on cat_per.cd_categoria = gen_cat_per.cd_categoria
    inner join tbl_Genero as gen
    on gen_cat_per.cd_genero = gen.cd_genero
    inner join tbl_Entreterimento_Genero as ent_gen
    on gen.cd_genero = ent_gen.cd_genero
    inner join tbl_Tipo_Entreterimento as tip
    on ent_gen.cd_entreterimento = tip.cd_entreterimento;
    
create view vw_consultaCategoriasPersonalidades
	as
	select 
	per.cd_personalidade,
    cat_per.cd_categoria
	from tbl_Personalidade as per inner join tbl_Categoria_Personalidade as cat_per
    on per.cd_categoria = cat_per.cd_categoria;

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

select * from vw_consultaPersonalidades;
select * from vw_consultaCategoriasPersonalidades where cd_personalidade = 2;
select * from vw_consultaDadosCategoriaPersonalidade;