use db_monkers_enter;

drop procedure if exists sp_cadastraUsuario;
	delimiter $$
create procedure sp_cadastraUsuario
	(
		in vNm_usuario varchar(90), 
        in vEmail_usuario varchar(90),
        in vSenha_usuario varchar(15)
    )
	begin 
		Insert into tbl_Usuario (cd_usuario, nome_usuario, data_de_cadastro, email_usuario, senha_usuario, cd_foto_perfil) values 
        (default, vNm_usuario, NOW(), vEmail_usuario, vSenha_usuario, 1);
	end $$
		delimiter;

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

drop procedure if exists sp_consultaCategoriasPersonalidadesPorId;
	delimiter $$
create procedure sp_consultaCategoriasPersonalidadesPorId
	(
		in vCd_personalidade int
	)
	begin
		select * from vw_consultaCategoriasPersonalidades 
        where cd_personalidade = vCd_personalidade;
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

drop procedure if exists sp_consultaGenerosPorCdCategoriaENmEntreterimento;
	delimiter $$
create procedure sp_consultaGenerosPorCdCategoriaENmEntreterimento
	(
		in vCd_categoria int,
        in vNm_entreterimento varchar(40)
	)
	begin
		select * from vw_consultaDadosCategoriaPersonalidade 
        where cd_categoria = vCd_categoria
        and
        nm_entreterimento = vNm_entreterimento;
	end $$
		delimiter ;

drop procedure if exists sp_consultaGenerosPorPersonalidadeENmEntreterimento;
	delimiter $$
create procedure sp_consultaGenerosPorPersonalidadeENmEntreterimento
	(
		in vCd_personalidade int,
        in vNm_entreterimento varchar(40)
	)
	begin
		SET @cd_categoria = 0;
        select resultado2.nm_entreterimento, 
        resultado2.nm_genero, resultado2.nm_categoria_personalidade, resultado2.cd_categoria, 
        resultado2.cd_genero, resultado2.cd_entreterimento from
        (select @cd_categoria := cd_categoria as 'varCdCategoria' from vw_consultaPersonalidades
        where cd_personalidade = vCd_personalidade) as resultado1,
		(select * from vw_consultaDadosCategoriaPersonalidade 
        where cd_categoria = @cd_categoria and nm_entreterimento = vNm_entreterimento) as resultado2;
	end $$
		delimiter ;

call sp_consultaGenerosPorPersonalidadeENmEntreterimento(7, 'Movie');
call sp_consultaGenerosPorCdCategoriaENmEntreterimento(1, 'Tv');
call sp_atualizaDadosUsuario(1, 'dogorBolaEsquerda', NULL, 'dogorberserk@gmail.com', 'souCriminoso', NULL, 4);
call sp_consultaDadosUsuarioPorId(1);