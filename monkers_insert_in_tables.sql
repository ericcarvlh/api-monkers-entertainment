use db_monkers_enter;

/* Inserindo fotos de perfil no banco */
Insert into tbl_Foto_Perfil values
(1, 'https://cdn.discordapp.com/attachments/1016110803641970698/1044997956731944980/monkeyyssluffy.png'),
(2, 'https://cdn.discordapp.com/attachments/1016110803641970698/1044997957247848519/monkeyysscoringa-removebg-preview.png'),
(3, 'https://cdn.discordapp.com/attachments/1016110803641970698/1044997957780512839/monkeyysseapol-removebg-preview.png'),
(4, 'https://cdn.discordapp.com/attachments/1016110803641970698/1044997958204145784/monkeyyssterror-removebg-preview.png'),
(5, 'https://cdn.discordapp.com/attachments/1016110803641970698/1044997958623567912/MONKRED.png');

/* Inserindo usuários no banco */
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

/* Inserindo os generos assicuadis as personalidades */
Insert into tbl_Genero_Categoria_Personalidade values
(16, 1), (10759, 1), 
(10770, 1), (80, 1), (10762, 1);

select * from tbl_Usuario;
select * from tbl_Personalidade;
select * from tbl_Tipo_Entreterimento;
select * from tbl_Entreterimento_Genero;
select * from tbl_Genero;
select * from tbl_Categoria_Personalidade;