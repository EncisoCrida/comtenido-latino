-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 10-04-2021 a las 00:44:15
-- Versión del servidor: 10.4.18-MariaDB
-- Versión de PHP: 8.0.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `contenido_latino`
--
DROP DATABASE IF EXISTS contenido_latino;
CREATE DATABASE contenido_latino;
USE contenido_latino;

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `cambiarImgPerfil` (IN `uploadedFile` VARCHAR(300), IN `id` INT(11))  BEGIN
UPDATE `tb_usuarios` SET `foto_perfil` = uploadedFile WHERE (`id_usuario` = id);
select 1;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `RegistrarAudio` (IN `autor` VARCHAR(20), IN `nombrePublicacion` VARCHAR(50), IN `caratulaRuta` VARCHAR(100), IN `reseña` VARCHAR(1000), IN `archivoRuta` VARCHAR(100), IN `categoria` INT(5), IN `usuario` INT(11))  BEGIN
INSERT INTO tb_audios (autor, nombre, caratula, resena, archivo, id_categoria, id_usuario, fecha_registro, likes, dislikes, comentarios) VALUES (autor, nombrePublicacion, caratulaRuta, reseña, archivoRuta, categoria, usuario, now(), 0, 0, 0);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `RegistrarComic` (IN `autor` VARCHAR(50), IN `nombrePublicacion` VARCHAR(100), IN `volumen` VARCHAR(4), IN `caratulaRuta` VARCHAR(100), IN `paginas` VARCHAR(10), IN `reseña` VARCHAR(1000), IN `archivoRuta` VARCHAR(100), IN `categoria` INT(4), IN `usuario` INT(11))  BEGIN
INSERT INTO `tb_comics` (`autor`, `nombre`, `volumen`, `caratula`, `paginas`, `resena`, `archivo`, `id_categoria`, `id_usuario`, `fecha_registro`, likes, dislikes, comentarios) VALUES (autor, nombrePublicacion, volumen, caratulaRuta, paginas, reseña, archivoRuta, categoria, usuario, now(), 0, 0, 0);
SELECT 1;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `RegistrarImagen` (IN `autor` VARCHAR(50), IN `nombrePublicacion` VARCHAR(100), IN `reseña` VARCHAR(1000), IN `archivoRuta` VARCHAR(100), IN `categoria` INT(3), IN `tags` VARCHAR(100), IN `usuario` VARCHAR(11))  BEGIN
INSERT INTO `tb_imagenes` (`autor`, `nombre`, `resena`, `archivo`, `id_categoria`, `tags`, `id_usuario`, `fecha_registro`, likes, dislikes, comentarios) VALUES (autor, nombrePublicacion, reseña, archivoRuta, categoria, tags, usuario, now(), 0, 0, 0);
SELECT 1;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `RegistrarLibro` (IN `autor_GET` VARCHAR(20), IN `nombre_GET` VARCHAR(50), IN `volumen_GET` VARCHAR(10), IN `caratula_GET` VARCHAR(100), IN `paginas_GET` VARCHAR(10), IN `resena_GET` VARCHAR(1000), IN `arvhivo_GET` VARCHAR(100), IN `id_categoria_GET` VARCHAR(5), IN `tags_GET` VARCHAR(100), IN `id_usuario_GET` VARCHAR(11))  BEGIN
INSERT INTO tb_libros (autor, nombre, volumen, caratula, paginas, resena, archivo, id_categoria, tags, id_usuario, fecha_registro, likes, dislikes, comentarios) VALUES (autor_GET, nombre_GET, volumen_GET, caratula_GET, paginas_GET, reseña_GET, arvhivo_GET, id_categoria_GET, tags_GET, id_usuario_GET, now(), 0, 0, 0);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `registrarUsuario` (IN `nombres` VARCHAR(40), IN `apellidos` VARCHAR(40), IN `usuario` VARCHAR(14), IN `correo` VARCHAR(80), IN `telefono` VARCHAR(15), IN `clave` VARCHAR(200), IN `pais` INT(4), IN `estado` INT(5), IN `municipio` VARCHAR(5))  BEGIN
DECLARE resultado boolean;
INSERT INTO `tb_usuarios`(`nombres`, `apellidos`, `usuario`, `correo`, `telefono`, `clave`, `id_pais`, `id_estado`, `id_mcpio`, `id_tipo_usuario`, `fecha_registro`, `foto_perfil`) VALUES (nombres, apellidos,usuario,correo, telefono, clave, pais, estado, municipio, '1',now(), 'fotoPerfil/img-perfil-default.png');
select 1;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `RegistrarVideo` (IN `autor` VARCHAR(20), IN `nombrePublicacion` VARCHAR(100), IN `caratulaRuta` VARCHAR(100), IN `reseña` VARCHAR(1000), IN `archivoRuta` VARCHAR(100), IN `categoria` INT(3), IN `usuario` INT(11))  BEGIN
INSERT INTO `tb_videos` (`autor`, `nombre`, `caratula`, `resena`, `archivo`, `id_categoria`, `id_usuario`, `fecha_registro`, likes, dislikes, comentarios) VALUES (autor, nombrePublicacion, caratulaRuta, reseña, archivoRuta, categoria, usuario, now(), 0, 0, 0);
SELECT 1;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `restablecerClave` (IN `correoSolicitado` VARCHAR(70), IN `clave` VARCHAR(300))  BEGIN
DECLARE cantidad INT(1);
declare id INT(4);
DECLARE resultado INT(1);
SET @cantidad:=(SELECT COUNT(*) FROM tb_usuarios WHERE tb_usuarios.correo=correoSolicitado);
IF @cantidad>0 THEN
set @id:=(select id_usuario from tb_usuarios where tb_usuarios.correo=correoSolicitado);
 UPDATE tb_usuarios SET clave=clave WHERE id_usuario=@id ;
 set @resultado = 1;
 SELECT @resultado;
ELSE
set @resultado = 2;
 SELECT @resultado;
END IF;
END$$

--
-- Funciones
--
CREATE DEFINER=`root`@`localhost` FUNCTION `buscarClave` (`correoBuscar` VARCHAR(100)) RETURNS VARCHAR(500) CHARSET utf8mb4 BEGIN
DECLARE cla VARCHAR(500);
set cla = '';
SET cla = (SELECT clave FROM tb_usuarios WHERE correo=correoBuscar);
RETURN cla;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `buscarUsuario` (`correoBuscar` VARCHAR(100)) RETURNS INT(11) BEGIN
declare resultado INT(2);
set resultado:=(select count(*) from tb_usuarios where correo = correoBuscar);

if resultado > 0 then
RETURN 1;
else
return 2;
END IF;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `buscar_libro` (`libroBuscar` VARCHAR(100)) RETURNS INT(11) BEGIN
DECLARE encontrados VARCHAR(500);
SET encontrados = (SELECT count(*) FROM tb_libros WHERE nombre=libroBuscar);
RETURN encontrados;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_audios`
--

CREATE TABLE `tb_audios` (
  `id` int(11) NOT NULL,
  `autor` varchar(30) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `caratula` varchar(300) NOT NULL,
  `resena` varchar(1000) NOT NULL,
  `archivo` varchar(100) NOT NULL,
  `id_categoria` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `fecha_registro` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_categorias`
--

CREATE TABLE `tb_categorias` (
  `id_categoria` int(11) NOT NULL,
  `categoria` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tb_categorias`
--

INSERT INTO `tb_categorias` (`id_categoria`, `categoria`) VALUES
(1, 'comedia'),
(2, 'infantil'),
(3, 'terror');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_comentarios`
--

CREATE TABLE `tb_comentarios` (
  `id_comentario` int(11) NOT NULL,
  `id_publicacion` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `fecha_comentario` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_comentarios_audios`
--

CREATE TABLE `tb_comentarios_audios` (
  `id_comentario` int(11) NOT NULL,
  `id_publicacion` int(11) NOT NULL,
  `comentario` varchar(200) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `fecha_comentario` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_comentarios_comics`
--

CREATE TABLE `tb_comentarios_comics` (
  `id_comentario` int(11) NOT NULL,
  `id_publicacion` int(11) NOT NULL,
  `comentario` varchar(200) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `fecha_comentario` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_comentarios_imagenes`
--

CREATE TABLE `tb_comentarios_imagenes` (
  `id_comentario` int(11) NOT NULL,
  `id_publicacion` int(11) NOT NULL,
  `comentario` varchar(200) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `fecha_comentario` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_comentarios_libros`
--

CREATE TABLE `tb_comentarios_libros` (
  `id_comentario` int(11) NOT NULL,
  `id_publicacion` int(11) NOT NULL,
  `comentario` varchar(200) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `fecha_comentario` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tb_comentarios_libros`
--

INSERT INTO `tb_comentarios_libros` (`id_comentario`, `id_publicacion`, `comentario`, `id_usuario`, `fecha_comentario`) VALUES
(47, 7, 'este es mi primer comentario', 12, '2021-04-08 17:03:08'),
(48, 11, 'aqui habia un comentario malo', 12, '2021-04-08 17:03:32'),
(49, 7, 'este es un segundo comentario de prueba', 12, '2021-04-09 16:36:01'),
(50, 8, 'este es otrooo coometario', 12, '2021-04-09 16:36:51');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_comentarios_videos`
--

CREATE TABLE `tb_comentarios_videos` (
  `id_comentario` int(11) NOT NULL,
  `id_publicacion` int(11) NOT NULL,
  `comentario` varchar(200) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `fecha_comentario` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_comics`
--

CREATE TABLE `tb_comics` (
  `id` int(11) NOT NULL,
  `autor` varchar(30) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `volumen` varchar(10) NOT NULL,
  `caratula` varchar(300) NOT NULL,
  `paginas` varchar(10) NOT NULL,
  `resena` varchar(1000) NOT NULL,
  `archivo` varchar(100) NOT NULL,
  `id_categoria` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `fecha_registro` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_compras`
--

CREATE TABLE `tb_compras` (
  `id_compra` int(11) NOT NULL,
  `compra` varchar(100) NOT NULL,
  `valor` float NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `fecha_compra` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_dislikes_audios`
--

CREATE TABLE `tb_dislikes_audios` (
  `id_like` int(11) NOT NULL,
  `id_publicacion` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `fecha_like` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_dislikes_comics`
--

CREATE TABLE `tb_dislikes_comics` (
  `id_like` int(11) NOT NULL,
  `id_publicacion` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `fecha_like` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_dislikes_imagenes`
--

CREATE TABLE `tb_dislikes_imagenes` (
  `id_like` int(11) NOT NULL,
  `id_publicacion` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `fecha_like` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_dislikes_libros`
--

CREATE TABLE `tb_dislikes_libros` (
  `id_like` int(11) NOT NULL,
  `id_publicacion` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `fecha_like` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tb_dislikes_libros`
--

INSERT INTO `tb_dislikes_libros` (`id_like`, `id_publicacion`, `id_usuario`, `fecha_like`) VALUES
(206, 18, 13, '2021-04-09 16:34:26');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_dislikes_videos`
--

CREATE TABLE `tb_dislikes_videos` (
  `id_like` int(11) NOT NULL,
  `id_publicacion` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `fecha_like` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_estados`
--

CREATE TABLE `tb_estados` (
  `id_estado` int(5) NOT NULL,
  `estado` varchar(60) DEFAULT NULL,
  `id_pais` int(5) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tb_estados`
--

INSERT INTO `tb_estados` (`id_estado`, `estado`, `id_pais`) VALUES
(0, 'SIN DEPARTAMENTO', 57),
(5, 'ANTIOQUIA', 57),
(8, 'ATLANTICO', 57),
(13, 'BOLIVAR', 57),
(15, 'BOYACA', 57),
(17, 'CALDAS', 57),
(18, 'CAQUETA', 57),
(19, 'CAUCA', 57),
(20, 'CESAR', 57),
(23, 'CORDOBA', 57),
(25, 'CUNDINAMARCA', 57),
(27, 'CHOCO', 57),
(41, 'HUILA', 57),
(44, 'LA GUAJIRA', 57),
(47, 'MAGDALENA', 57),
(50, 'META', 57),
(52, 'NARIÑO', 57),
(54, 'NORTE DE SANTANDER', 57),
(63, 'QUINDIO', 57),
(66, 'RISARALDA', 57),
(68, 'SANTANDER', 57),
(70, 'SUCRE', 57),
(73, 'TOLIMA', 57),
(76, 'VALLE', 57),
(81, 'ARAUCA', 57),
(85, 'CASANARE', 57),
(86, 'PUTUMAYO', 57),
(88, 'SAN ANDRES', 57),
(91, 'AMAZONAS', 57),
(94, 'GUAINIA', 57),
(95, 'GUAVIARE', 57),
(97, 'VAUPES', 57),
(99, 'VICHADA', 57),
(580, 'PERU', 58),
(590, 'GUATEMALA', 59),
(600, 'BRASIL', 600),
(700, 'U.S.A', 70),
(710, 'Mexico DF', 71),
(720, 'Chile', 72),
(730, 'Argentina', 73),
(740, 'VENEZUELA', 74),
(750, 'BOLIVIA', 75),
(770, 'Switzerland', 77),
(800, 'ECUADOR', 80),
(810, 'España', 81),
(7001, 'FLORIDA', 70),
(7002, 'ILLINOIS', 70);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_favoritos`
--

CREATE TABLE `tb_favoritos` (
  `id_favorito` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `id_publicacion` int(11) NOT NULL,
  `fecha_favorito` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_imagenes`
--

CREATE TABLE `tb_imagenes` (
  `id` int(11) NOT NULL,
  `autor` varchar(30) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `resena` varchar(1000) NOT NULL,
  `archivo` varchar(100) NOT NULL,
  `id_categoria` int(11) NOT NULL,
  `tags` varchar(100) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `fecha_registro` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tb_imagenes`
--

INSERT INTO `tb_imagenes` (`id`, `autor`, `nombre`, `resena`, `archivo`, `id_categoria`, `tags`, `id_usuario`, `fecha_registro`) VALUES
(4, 'crida', 'pisaje', 'reseña', '1617072529_uchiha-brothers-❤-4k-hd-desktop-wallpaper-for-4k-ultra-hd-tv.jpg', 1, 'dsa', 12, '2021-03-29 21:48:49'),
(5, 'enciso', 'img prueba', 'row', '1617072842_OIP.jpg', 1, 'dsa', 12, '2021-03-29 21:54:02'),
(6, 'enciso', 'img prueba2', 'aSas', '1617072919_uchiha-brothers-❤-4k-hd-desktop-wallpaper-for-4k-ultra-hd-tv.jpg', 1, 'dsa', 12, '2021-03-29 21:55:19'),
(7, 'enciso', 'img prueba3', 'wdad', '1617072991_uchiha-brothers-❤-4k-hd-desktop-wallpaper-for-4k-ultra-hd-tv.jpg', 1, 'dsa', 12, '2021-03-29 21:56:31'),
(8, 'enciso', 'img prueba4', 'saAS', '1617073034_OIP.jpg', 1, 'dsa', 12, '2021-03-29 21:57:14'),
(10, 'enciso', 'img prueba5', 'ads', '1617073171_uchiha-brothers-❤-4k-hd-desktop-wallpaper-for-4k-ultra-hd-tv.jpg', 1, 'dsa', 12, '2021-03-29 21:59:31'),
(11, 'enciso', 'img prueba6', 'dsaasd', '1617073296_OIP.jpg', 1, 'dsa', 12, '2021-03-29 22:01:36'),
(12, 'enciso', 'img prueba7', 'jzsjhfjksdhfk', '1617073661_OIP.jpg', 1, 'dsa', 12, '2021-03-29 22:07:41'),
(13, 'en', 'img prueba8', 'ASDASDASD', '1617073739_OIP.jpg', 1, 'asASASD', 12, '2021-03-29 22:08:59'),
(14, 'enciso', 'img prueba9', 'sx<x<z', '1617074030_OIP.jpg', 1, 'asASASD', 12, '2021-03-29 22:13:50'),
(15, 'enciso', 'img prueba10', 'sdasdasda', '1617074199_OIP.jpg', 1, 'asASASD', 12, '2021-03-29 22:16:39');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_libros`
--

CREATE TABLE `tb_libros` (
  `id` int(11) NOT NULL,
  `autor` varchar(30) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `volumen` varchar(10) NOT NULL,
  `caratula` varchar(300) NOT NULL,
  `paginas` varchar(10) NOT NULL,
  `resena` varchar(1000) NOT NULL,
  `archivo` varchar(100) NOT NULL,
  `id_categoria` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `tags` varchar(500) NOT NULL,
  `fecha_registro` datetime NOT NULL,
  `likes` int(11) NOT NULL,
  `dislikes` int(11) NOT NULL,
  `comentarios` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tb_libros`
--

INSERT INTO `tb_libros` (`id`, `autor`, `nombre`, `volumen`, `caratula`, `paginas`, `resena`, `archivo`, `id_categoria`, `id_usuario`, `tags`, `fecha_registro`, `likes`, `dislikes`, `comentarios`) VALUES
(7, 'crida', 'ana gomez', '1', '1616824407_OIP.jpg', '1', 'sdsadasdas', '1616824407_lorem_ipsum_definicion.pdf', 1, 12, 'lorem', '2021-03-27 00:53:27', 0, 0, 2),
(8, 'crida', 'otro', '1', '1616825148_OIP.jpg', '1', 'ssadada', '1616825148_lorem_ipsum_definicion.pdf', 2, 12, 'lor', '2021-03-27 01:05:48', 1, 2, 1),
(11, 'crida', 'el macho2', '2', '1617073919_OIP.jpg', '45', 'sdsadsadasd', '1617073919_lorem_ipsum_definicion.pdf', 1, 12, 'lorem', '2021-03-29 22:11:59', 0, 1, 1),
(13, 'crida', 'pruebas de imagenes', '1', '1617148781_uchiha-brothers-❤-4k-hd-desktop-wallpaper-for-4k-ultra-hd-tv.jpg', '34', 'esta es otra pueba', '1617148781_lorem_ipsum_definicion.pdf', 1, 12, '#comedia #vampir', '2021-03-30 18:59:42', 0, 0, 0),
(16, 'crida', 'prueba likes', '1', '1617495103_uchiha-brothers-❤-4k-hd-desktop-wallpaper-for-4k-ultra-hd-tv.jpg', '12', 'prueba con nuevos campos de likes #1', '1617495103_lorem_ipsum_definicion.pdf', 1, 12, 'lorem', '2021-04-03 19:11:43', 0, 0, 0),
(17, 'crida', 'el macho', '1', '1617552433_OIP.jpg', '1', 'el machooo xd', '1617552433_GFPI-F-135_Guia BD.pdf', 1, 12, 'lorem', '2021-04-04 11:07:13', 0, 0, 0),
(18, 'crida', 'libro de prueba 2', '2', '1617810411_OIP.jpg', '23', 'esta reseña es una prueba porque yo sjjxhk<jhxjADSHLasdklhKADSHKLHadshljkashdjkhADSHJKLASHDJKHAsdhljkashdjkadshjk', '1617810411_GFPI-F-135_Guia BD.pdf', 1, 12, 'ficcion', '2021-04-07 10:46:51', 1, 1, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_likes_audios`
--

CREATE TABLE `tb_likes_audios` (
  `id_like` int(11) NOT NULL,
  `id_publicacion` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `fecha_like` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_likes_comics`
--

CREATE TABLE `tb_likes_comics` (
  `id_like` int(11) NOT NULL,
  `id_publicacion` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `fecha_like` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_likes_imagenes`
--

CREATE TABLE `tb_likes_imagenes` (
  `id_like` int(11) NOT NULL,
  `id_publicacion` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `fecha_like` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_likes_libros`
--

CREATE TABLE `tb_likes_libros` (
  `id_like` int(11) NOT NULL,
  `id_publicacion` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `fecha_like` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tb_likes_libros`
--

INSERT INTO `tb_likes_libros` (`id_like`, `id_publicacion`, `id_usuario`, `fecha_like`) VALUES
(111, 8, 13, '2021-04-04 12:11:09'),
(304, 18, 12, '2021-04-09 16:33:33');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_likes_videos`
--

CREATE TABLE `tb_likes_videos` (
  `id_like` int(11) NOT NULL,
  `id_publicacion` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `fecha_like` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_mendajes`
--

CREATE TABLE `tb_mendajes` (
  `id_mensaje` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `mensaje` varchar(1000) NOT NULL,
  `estado` int(1) NOT NULL,
  `fecha_mensaje` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_monedas`
--

CREATE TABLE `tb_monedas` (
  `id_moneda` int(11) NOT NULL,
  `cantidad` float NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `fecha_llegada` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_municipios`
--

CREATE TABLE `tb_municipios` (
  `id_mcpio` int(11) NOT NULL,
  `nombre_mcpio` varchar(60) DEFAULT NULL,
  `id_estado` int(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tb_municipios`
--

INSERT INTO `tb_municipios` (`id_mcpio`, `nombre_mcpio`, `id_estado`) VALUES
(1, 'SIN MUNICIPIO', 0),
(2, 'BOGOTA', 25),
(3, 'CARTAGENA', 13),
(4, 'CALAMAR', 13),
(5, 'CANTAGALLO', 13),
(6, 'CICUCO', 13),
(7, 'CORDOBA', 13),
(8, 'CLEMENCIA', 13),
(9, 'EL CARMEN DE BOLIVAR', 13),
(10, 'EL GUAMO', 13),
(11, 'EL PEÑON', 13),
(12, 'ALTOS DEL ROSARIO', 13),
(13, 'HATILLO DE LOBA', 13),
(14, 'ARENAL', 13),
(15, 'MAGANGUE', 13),
(16, 'MAHATES', 13),
(17, 'MARGARITA', 13),
(18, 'MARIA LA BAJA', 13),
(19, 'MONTECRISTO', 13),
(20, 'MOMPOS', 13),
(21, 'MORALES', 13),
(22, 'ARJONA', 13),
(23, 'PINILLOS', 13),
(24, 'REGIDOR', 13),
(25, 'ACHI', 13),
(26, 'RIO VIEJO', 13),
(27, 'ARROYOHONDO', 13),
(28, 'SAN CRISTOBAL', 13),
(29, 'SAN ESTANISLAO', 13),
(30, 'SAN FERNANDO', 13),
(31, 'SAN JACINTO', 13),
(32, 'SAN JACINTO DEL CAUCA', 13),
(33, 'SAN JUAN NEPOMUCENO', 13),
(34, 'SAN MARTIN DE LOBA', 13),
(35, 'SAN PABLO', 13),
(36, 'SANTA CATALINA', 13),
(37, 'SANTA ROSA', 13),
(38, 'SANTA ROSA DEL SUR', 13),
(39, 'BARRANCO DE LOBA', 13),
(40, 'SIMITI', 13),
(41, 'SOPLAVIENTO', 13),
(42, 'TALAIGUA NUEVO', 13),
(43, 'TIQUISIO', 13),
(44, 'TURBACO', 13),
(45, 'TURBANA', 13),
(46, 'VILLANUEVA', 13),
(47, 'ZAMBRANO', 13),
(48, 'TUNJA', 15),
(49, 'BOYACA', 15),
(50, 'BRICEÑO', 15),
(51, 'BUENAVISTA', 15),
(52, 'BUSBANZA', 15),
(53, 'CALDAS', 15),
(54, 'CAMPOHERMOSO', 15),
(55, 'CERINZA', 15),
(56, 'CHINAVITA', 15),
(57, 'CHIQUINQUIRA', 15),
(58, 'CHISCAS', 15),
(59, 'CHITA', 15),
(60, 'CHITARAQUE', 15),
(61, 'CHIVATA', 15),
(62, 'CIENEGA', 15),
(63, 'COMBITA', 15),
(64, 'COPER', 15),
(65, 'CORRALES', 15),
(66, 'COVARACHIA', 15),
(67, 'ALMEIDA', 15),
(68, 'CUBARA', 15),
(69, 'CUCAITA', 15),
(70, 'CUITIVA', 15),
(71, 'CHIQUIZA', 15),
(72, 'CHIVOR', 15),
(73, 'DUITAMA', 15),
(74, 'EL COCUY', 15),
(75, 'EL ESPINO', 15),
(76, 'FIRAVITOBA', 15),
(77, 'FLORESTA', 15),
(78, 'GACHANTIVA', 15),
(79, 'GAMEZA', 15),
(80, 'GARAGOA', 15),
(81, 'GUACAMAYAS', 15),
(82, 'GUATEQUE', 15),
(83, 'GUAYATA', 15),
(84, 'GUICAN', 15),
(85, 'IZA', 15),
(86, 'JENESANO', 15),
(87, 'JERICO', 15),
(88, 'LABRANZAGRANDE', 15),
(89, 'LA CAPILLA', 15),
(90, 'LA VICTORIA', 15),
(91, 'LA UVITA', 15),
(92, 'VILLA DE LEYVA', 15),
(93, 'MACANAL', 15),
(94, 'MARIPI', 15),
(95, 'MIRAFLORES', 15),
(96, 'MONGUA', 15),
(97, 'MONGUI', 15),
(98, 'MONIQUIRA', 15),
(99, 'AQUITANIA', 15),
(100, 'MOTAVITA', 15),
(101, 'MUZO', 15),
(102, 'NOBSA', 15),
(103, 'NUEVO COLON', 15),
(104, 'OICATA', 15),
(105, 'OTANCHE', 15),
(106, 'ARCABUCO', 15),
(107, 'PACHAVITA', 15),
(108, 'PAEZ', 15),
(109, 'PAIPA', 15),
(110, 'PAJARITO', 15),
(111, 'PANQUEBA', 15),
(112, 'PAUNA', 15),
(113, 'PAYA', 15),
(114, 'PAZ DE RIO', 15),
(115, 'PESCA', 15),
(116, 'PISBA', 15),
(117, 'PUERTO BOYACA', 15),
(118, 'QUIPAMA', 15),
(119, 'RAMIRIQUI', 15),
(120, 'RAQUIRA', 15),
(121, 'RONDON', 15),
(122, 'SABOYA', 15),
(123, 'SACHICA', 15),
(124, 'SAMACA', 15),
(125, 'SAN EDUARDO', 15),
(126, 'SAN JOSE DE PARE', 15),
(127, 'SAN LUIS DE GACENO', 15),
(128, 'SAN MATEO', 15),
(129, 'SAN MIGUEL DE SEMA', 15),
(130, 'SAN PABLO DE BORBUR', 15),
(131, 'SANTANA', 15),
(132, 'SANTA MARIA', 15),
(133, 'SANTA ROSA DE VITERBO', 15),
(134, 'SANTA SOFIA', 15),
(135, 'SATIVANORTE', 15),
(136, 'SATIVASUR', 15),
(137, 'SIACHOQUE', 15),
(138, 'SOATA', 15),
(139, 'SOCOTA', 15),
(140, 'SOCHA', 15),
(141, 'SOGAMOSO', 15),
(142, 'SOMONDOCO', 15),
(143, 'SORA', 15),
(144, 'SOTAQUIRA', 15),
(145, 'SORACA', 15),
(146, 'SUSACON', 15),
(147, 'SUTAMARCHAN', 15),
(148, 'SUTATENZA', 15),
(149, 'TASCO', 15),
(150, 'TENZA', 15),
(151, 'TIBANA', 15),
(152, 'TIBASOSA', 15),
(153, 'TINJACA', 15),
(154, 'TIPACOQUE', 15),
(155, 'TOCA', 15),
(156, 'TOGUI', 15),
(157, 'TOPAGA', 15),
(158, 'TOTA', 15),
(159, 'TUNUNGUA', 15),
(160, 'TURMEQUE', 15),
(161, 'TUTA', 15),
(162, 'TUTAZA', 15),
(163, 'UMBITA', 15),
(164, 'VENTAQUEMADA', 15),
(165, 'BELEN', 15),
(166, 'VIRACACHA', 15),
(167, 'ZETAQUIRA', 15),
(168, 'BERBEO', 15),
(169, 'BETEITIVA', 15),
(170, 'BOAVITA', 15),
(171, 'MANIZALES', 17),
(172, 'AGUADAS', 17),
(173, 'CHINCHINA', 17),
(174, 'FILADELFIA', 17),
(175, 'LA DORADA', 17),
(176, 'LA MERCED', 17),
(177, 'ANSERMA', 17),
(178, 'MANZANARES', 17),
(179, 'MARMATO', 17),
(180, 'MARQUETALIA', 17),
(181, 'MARULANDA', 17),
(182, 'NEIRA', 17),
(183, 'NORCASIA', 17),
(184, 'ARANZAZU', 17),
(185, 'PACORA', 17),
(186, 'PALESTINA', 17),
(187, 'PENSILVANIA', 17),
(188, 'RIOSUCIO', 17),
(189, 'RISARALDA', 17),
(190, 'SALAMINA', 17),
(191, 'SAMANA', 17),
(192, 'SAN JOSE', 17),
(193, 'SUPIA', 17),
(194, 'VICTORIA', 17),
(195, 'VILLAMARIA', 17),
(196, 'VITERBO', 17),
(197, 'BELALCAZAR', 17),
(198, 'FLORENCIA', 18),
(199, 'CARTAGENA DEL CHAIRA', 18),
(200, 'CURILLO', 18),
(201, 'EL DONCELLO', 18),
(202, 'EL PAUJIL', 18),
(203, 'ALBANIA', 18),
(204, 'LA MONTAÑITA', 18),
(205, 'MILAN', 18),
(206, 'MORELIA', 18),
(207, 'PUERTO RICO', 18),
(208, 'SAN JOSE DEL FRAGUA', 18),
(209, 'SAN VICENTE DEL CAGUAN', 18),
(210, 'SOLANO', 18),
(211, 'SOLITA', 18),
(212, 'VALPARAISO', 18),
(213, 'BELEN DE LOS ANDAQUIES', 18),
(214, 'POPAYAN', 19),
(215, 'BOLIVAR', 19),
(216, 'BUENOS AIRES', 19),
(217, 'CAJIBIO', 19),
(218, 'CALDONO', 19),
(219, 'CALOTO', 19),
(220, 'CORINTO', 19),
(221, 'ALMAGUER', 19),
(222, 'EL TAMBO', 19),
(223, 'FLORENCIA', 19),
(224, 'GUAPI', 19),
(225, 'INZA', 19),
(226, 'JAMBALO', 19),
(227, 'LA SIERRA', 19),
(228, 'LA VEGA', 19),
(229, 'LOPEZ', 19),
(230, 'MERCADERES', 19),
(231, 'MIRANDA', 19),
(232, 'MORALES', 19),
(233, 'ARGELIA', 19),
(234, 'PADILLA', 19),
(235, 'PAEZ', 19),
(236, 'PATIA', 19),
(237, 'PIAMONTE', 19),
(238, 'PIENDAMO', 19),
(239, 'PUERTO TEJADA', 19),
(240, 'PURACE', 19),
(241, 'ROSAS', 19),
(242, 'SAN SEBASTIAN', 19),
(243, 'SANTANDER DE QUILICHAO', 19),
(244, 'SANTA ROSA', 19),
(245, 'SILVIA', 19),
(246, 'BALBOA', 19),
(247, 'SOTARA', 19),
(248, 'SUAREZ', 19),
(249, 'SUCRE', 19),
(250, 'TIMBIO', 19),
(251, 'TIMBIQUI', 19),
(252, 'TORIBIO', 19),
(253, 'TOTORO', 19),
(254, 'VILLA RICA', 19),
(255, 'VALLEDUPAR', 20),
(256, 'AGUACHICA', 20),
(257, 'AGUSTIN CODAZZI', 20),
(258, 'CHIMICHAGUA', 20),
(259, 'CHIRIGUANA', 20),
(260, 'CURUMANI', 20),
(261, 'EL COPEY', 20),
(262, 'EL PASO', 20),
(263, 'GAMARRA', 20),
(264, 'GONZALEZ', 20),
(265, 'ASTREA', 20),
(266, 'LA GLORIA', 20),
(267, 'LA JAGUA DE IBIRICO', 20),
(268, 'MANAURE BALCON DEL CESAR', 20),
(269, 'BECERRIL', 20),
(270, 'PAILITAS', 20),
(271, 'PELAYA', 20),
(272, 'PUEBLO BELLO', 20),
(273, 'BOSCONIA', 20),
(274, 'RIO DE ORO', 20),
(275, 'LA PAZ', 20),
(276, 'LA PAZ (ROBLES)', 20),
(277, 'SAN ALBERTO', 20),
(278, 'SAN DIEGO', 20),
(279, 'SAN MARTIN', 20),
(280, 'TAMALAMEQUE', 20),
(281, 'MONTERIA', 23),
(282, 'CERETE', 23),
(283, 'CHIMA', 23),
(284, 'CHINU', 23),
(285, 'CIENAGA DE ORO', 23),
(286, 'COTORRA', 23),
(287, 'LA APARTADA', 23),
(288, 'LORICA', 23),
(289, 'LOS CORDOBAS', 23),
(290, 'MOMIL', 23),
(291, 'MONTELIBANO', 23),
(292, 'MOÑITOS', 23),
(293, 'PLANETA RICA', 23),
(294, 'PUEBLO NUEVO', 23),
(295, 'PUERTO ESCONDIDO', 23),
(296, 'PUERTO LIBERTADOR', 23),
(297, 'PURISIMA', 23),
(298, 'SAHAGUN', 23),
(299, 'SAN ANDRES SOTAVENTO', 23),
(300, 'SAN ANTERO', 23),
(301, 'SAN BERNARDO DEL VIENTO', 23),
(302, 'SAN CARLOS', 23),
(303, 'AYAPEL', 23),
(304, 'SAN PELAYO', 23),
(305, 'BUENAVISTA', 23),
(306, 'TIERRALTA', 23),
(307, 'VALENCIA', 23),
(308, 'CANALETE', 23),
(309, 'AGUA DE DIOS', 25),
(310, 'CABRERA', 25),
(311, 'CACHIPAY', 25),
(312, 'CAJICA', 25),
(313, 'CAPARRAPI', 25),
(314, 'CAQUEZA', 25),
(315, 'CARMEN DE CARUPA', 25),
(316, 'CHAGUANI', 25),
(317, 'CHIA', 25),
(318, 'CHIPAQUE', 25),
(319, 'CHOACHI', 25),
(320, 'CHOCONTA', 25),
(321, 'ALBAN', 25),
(322, 'COGUA', 25),
(323, 'COTA', 25),
(324, 'CUCUNUBA', 25),
(325, 'EL COLEGIO', 25),
(326, 'EL PEÑON', 25),
(327, 'EL ROSAL', 25),
(328, 'FACATATIVA', 25),
(329, 'FOMEQUE', 25),
(330, 'FOSCA', 25),
(331, 'FUNZA', 25),
(332, 'FUQUENE', 25),
(333, 'FUSAGASUGA', 25),
(334, 'GACHALA', 25),
(335, 'GACHANCIPA', 25),
(336, 'GACHETA', 25),
(337, 'GAMA', 25),
(338, 'GIRARDOT', 25),
(339, 'GRANADA', 25),
(340, 'GUACHETA', 25),
(341, 'GUADUAS', 25),
(342, 'GUASCA', 25),
(343, 'GUATAQUI', 25),
(344, 'GUATAVITA', 25),
(345, 'GUAYABAL DE SIQUIMA', 25),
(346, 'GUAYABETAL', 25),
(347, 'GUTIERREZ', 25),
(348, 'ANAPOIMA', 25),
(349, 'JERUSALEN', 25),
(350, 'JUNIN', 25),
(351, 'LA CALERA', 25),
(352, 'LA MESA', 25),
(353, 'LA PALMA', 25),
(354, 'LA PEÑA', 25),
(355, 'ANOLAIMA', 25),
(356, 'LA VEGA', 25),
(357, 'LENGUAZAQUE', 25),
(358, 'MACHETA', 25),
(359, 'MADRID', 25),
(360, 'MANTA', 25),
(361, 'MEDINA', 25),
(362, 'MOSQUERA', 25),
(363, 'NARIÑO', 25),
(364, 'NEMOCON', 25),
(365, 'NILO', 25),
(366, 'NIMAIMA', 25),
(367, 'NOCAIMA', 25),
(368, 'VENECIA', 25),
(369, 'PACHO', 25),
(370, 'PAIME', 25),
(371, 'PANDI', 25),
(372, 'ARBELAEZ', 25),
(373, 'PARATEBUENO', 25),
(374, 'PASCA', 25),
(375, 'PUERTO SALGAR', 25),
(376, 'PULI', 25),
(377, 'QUEBRADANEGRA', 25),
(378, 'QUETAME', 25),
(379, 'QUIPILE', 25),
(380, 'APULO', 25),
(381, 'RICAURTE', 25),
(382, 'SAN ANTONIO DEL TEQUENDAMA', 25),
(383, 'SAN BERNARDO', 25),
(384, 'SAN CAYETANO', 25),
(385, 'SAN FRANCISCO', 25),
(386, 'SAN JUAN DE RIO SECO', 25),
(387, 'SASAIMA', 25),
(388, 'SESQUILE', 25),
(389, 'SIBATE', 25),
(390, 'SILVANIA', 25),
(391, 'SIMIJACA', 25),
(392, 'SOACHA', 25),
(393, 'SOPO', 25),
(394, 'SUBACHOQUE', 25),
(395, 'SUESCA', 25),
(396, 'SUPATA', 25),
(397, 'SUSA', 25),
(398, 'SUTATAUSA', 25),
(399, 'TABIO', 25),
(400, 'TAUSA', 25),
(401, 'TENA', 25),
(402, 'TENJO', 25),
(403, 'TIBACUY', 25),
(404, 'TIBIRITA', 25),
(405, 'TOCAIMA', 25),
(406, 'TOCANCIPA', 25),
(407, 'TOPAIPI', 25),
(408, 'UBALA', 25),
(409, 'UBAQUE', 25),
(410, 'UBATE', 25),
(411, 'UNE', 25),
(412, 'UTICA', 25),
(413, 'BELTRAN', 25),
(414, 'VERGARA', 25),
(415, 'VIANI', 25),
(416, 'VILLAGOMEZ', 25),
(417, 'VILLAPINZON', 25),
(418, 'VILLETA', 25),
(419, 'VIOTA', 25),
(420, 'YACOPI', 25),
(421, 'ZIPACON', 25),
(422, 'ZIPAQUIRA', 25),
(423, 'BITUIMA', 25),
(424, 'BOJACA', 25),
(425, 'QUIBDO', 27),
(426, 'EL CANTON DEL SAN PABLO', 27),
(427, 'CARMEN DEL DARIEN', 27),
(428, 'CERTEGUI', 27),
(429, 'CONDOTO', 27),
(430, 'EL CARMEN DE ATRATO', 27),
(431, 'ALTO BAUDO', 27),
(432, 'EL LITORAL DEL SAN JUAN', 27),
(433, 'ISTMINA', 27),
(434, 'JURADO', 27),
(435, 'LLORO', 27),
(436, 'MEDIO ATRATO', 27),
(437, 'MEDIO BAUDO', 27),
(438, 'MEDIO SAN JUAN', 27),
(439, 'NOVITA', 27),
(440, 'NUQUI', 27),
(441, 'ATRATO', 27),
(442, 'RIO IRO', 27),
(443, 'ACANDI', 27),
(444, 'RIO QUITO', 27),
(445, 'RIOSUCIO', 27),
(446, 'SAN JOSE DEL PALMAR', 27),
(447, 'BAGADO', 27),
(448, 'SIPI', 27),
(449, 'BAHIA SOLANO', 27),
(450, 'BAJO BAUDO', 27),
(451, 'TADO', 27),
(452, 'UNGUIA', 27),
(453, 'UNION PANAMERICANA', 27),
(454, 'BELEN DE BAJIRA', 27),
(455, 'MALPELO', 27),
(456, 'BOJAYA', 27),
(457, 'NEIVA', 41),
(458, 'AGRADO', 41),
(459, 'CAMPOALEGRE', 41),
(460, 'AIPE', 41),
(461, 'ALGECIRAS', 41),
(462, 'COLOMBIA', 41),
(463, 'ELIAS', 41),
(464, 'ALTAMIRA', 41),
(465, 'GARZON', 41),
(466, 'GIGANTE', 41),
(467, 'GUADALUPE', 41),
(468, 'HOBO', 41),
(469, 'IQUIRA', 41),
(470, 'ISNOS', 41),
(471, 'LA ARGENTINA', 41),
(472, 'LA PLATA', 41),
(473, 'NATAGA', 41),
(474, 'OPORAPA', 41),
(475, 'PAICOL', 41),
(476, 'PALERMO', 41),
(477, 'PALESTINA', 41),
(478, 'PITAL', 41),
(479, 'PITALITO', 41),
(480, 'ACEVEDO', 41),
(481, 'RIVERA', 41),
(482, 'SALADOBLANCO', 41),
(483, 'SAN AGUSTIN', 41),
(484, 'SANTA MARIA', 41),
(485, 'SUAZA', 41),
(486, 'BARAYA', 41),
(487, 'TARQUI', 41),
(488, 'TESALIA', 41),
(489, 'TELLO', 41),
(490, 'TERUEL', 41),
(491, 'TIMANA', 41),
(492, 'VILLAVIEJA', 41),
(493, 'YAGUARA', 41),
(494, 'RIOHACHA', 44),
(495, 'EL MOLINO', 44),
(496, 'FONSECA', 44),
(497, 'ALBANIA', 44),
(498, 'HATONUEVO', 44),
(499, 'LA JAGUA DEL PILAR', 44),
(500, 'MAICAO', 44),
(501, 'MANAURE', 44),
(502, 'SAN JUAN DEL CESAR', 44),
(503, 'BARRANCAS', 44),
(504, 'URIBIA', 44),
(505, 'URUMITA', 44),
(506, 'VILLANUEVA', 44),
(507, 'DIBULLA', 44),
(508, 'DISTRACCION', 44),
(509, 'SANTA MARTA', 47),
(510, 'CERRO SAN ANTONIO', 47),
(511, 'CHIBOLO', 47),
(512, 'CIENAGA', 47),
(513, 'CONCORDIA', 47),
(514, 'EL BANCO', 47),
(515, 'EL PIÑON', 47),
(516, 'EL RETEN', 47),
(517, 'FUNDACION', 47),
(518, 'ALGARROBO', 47),
(519, 'GUAMAL', 47),
(520, 'NUEVA GRANADA', 47),
(521, 'ARACATACA', 47),
(522, 'PEDRAZA', 47),
(523, 'PIJIÑO DEL CARMEN', 47),
(524, 'PIVIJAY', 47),
(525, 'PLATO', 47),
(526, 'PUEBLOVIEJO', 47),
(527, 'ARIGUANI', 47),
(528, 'ARIGUANI (EL DIFICIL)', 47),
(529, 'REMOLINO', 47),
(530, 'SABANAS DE SAN ANGEL', 47),
(531, 'SALAMINA', 47),
(532, 'SAN SEBASTIAN DE BUENAVISTA', 47),
(533, 'SAN ZENON', 47),
(534, 'SANTA ANA', 47),
(535, 'SANTA BARBARA DE PINTO', 47),
(536, 'SITIONUEVO', 47),
(537, 'TENERIFE', 47),
(538, 'ZAPAYAN', 47),
(539, 'ZONA BANANERA', 47),
(540, 'MEDELLIN', 5),
(541, 'CIUDAD BOLIVAR', 5),
(542, 'BRICEÑO', 5),
(543, 'BURITICA', 5),
(544, 'CACERES', 5),
(545, 'CAICEDO', 5),
(546, 'CALDAS', 5),
(547, 'CAMPAMENTO', 5),
(548, 'CAÑASGORDAS', 5),
(549, 'CARACOLI', 5),
(550, 'CARAMANTA', 5),
(551, 'CAREPA', 5),
(552, 'EL CARMEN DE VIBORAL', 5),
(553, 'CAROLINA', 5),
(554, 'CAUCASIA', 5),
(555, 'CHIGORODO', 5),
(556, 'CISNEROS', 5),
(557, 'COCORNA', 5),
(558, 'ABEJORRAL', 5),
(559, 'CONCEPCION', 5),
(560, 'CONCORDIA', 5),
(561, 'ALEJANDRIA', 5),
(562, 'COPACABANA', 5),
(563, 'DABEIBA', 5),
(564, 'DON MATIAS', 5),
(565, 'EBEJICO', 5),
(566, 'EL BAGRE', 5),
(567, 'ENTRERRIOS', 5),
(568, 'ENVIGADO', 5),
(569, 'FREDONIA', 5),
(570, 'FRONTINO', 5),
(571, 'AMAGA', 5),
(572, 'GIRALDO', 5),
(573, 'GIRARDOTA', 5),
(574, 'AMALFI', 5),
(575, 'GOMEZ PLATA', 5),
(576, 'GRANADA', 5),
(577, 'GUADALUPE', 5),
(578, 'GUARNE', 5),
(579, 'GUATAPE', 5),
(580, 'ANDES', 5),
(581, 'HELICONIA', 5),
(582, 'HISPANIA', 5),
(583, 'ANGELOPOLIS', 5),
(584, 'ITAGUI', 5),
(585, 'ITUANGO', 5),
(586, 'JARDIN', 5),
(587, 'JERICO', 5),
(588, 'LA CEJA', 5),
(589, 'ANGOSTURA', 5),
(590, 'LA ESTRELLA', 5),
(591, 'LA PINTADA', 5),
(592, 'ABRIAQUI', 5),
(593, 'ANORI', 5),
(594, 'LA UNION', 5),
(595, 'LIBORINA', 5),
(596, 'ANTIOQUIA', 5),
(597, 'MACEO', 5),
(598, 'ANZA', 5),
(599, 'MARINILLA', 5),
(600, 'APARTADO', 5),
(601, 'MONTEBELLO', 5),
(602, 'MURINDO', 5),
(603, 'MUTATA', 5),
(604, 'NARIÑO', 5),
(605, 'NECOCLI', 5),
(606, 'NECHI', 5),
(607, 'OLAYA', 5),
(608, 'ARBOLETES', 5),
(609, 'PEÑOL', 5),
(610, 'PEQUE', 5),
(611, 'ARGELIA', 5),
(612, 'PUEBLORRICO', 5),
(613, 'PUERTO BERRIO', 5),
(614, 'PUERTO NARE', 5),
(615, 'ARMENIA', 5),
(616, 'PUERTO TRIUNFO', 5),
(617, 'REMEDIOS', 5),
(618, 'RETIRO', 5),
(619, 'RIONEGRO', 5),
(620, 'SABANALARGA', 5),
(621, 'SABANETA', 5),
(622, 'SALGAR', 5),
(623, 'SAN ANDRES', 5),
(624, 'SAN CARLOS', 5),
(625, 'SAN FRANCISCO', 5),
(626, 'SAN JERONIMO', 5),
(627, 'SAN JOSE DE LA MONTAÑA', 5),
(628, 'SAN JUAN DE URABA', 5),
(629, 'SAN LUIS', 5),
(630, 'SAN PEDRO', 5),
(631, 'SAN PEDRO DE URABA', 5),
(632, 'SAN RAFAEL', 5),
(633, 'SAN ROQUE', 5),
(634, 'SAN VICENTE', 5),
(635, 'SANTA BARBARA', 5),
(636, 'SANTA ROSA DE OSOS', 5),
(637, 'SANTO DOMINGO', 5),
(638, 'EL SANTUARIO', 5),
(639, 'SEGOVIA', 5),
(640, 'SONSON', 5),
(641, 'SOPETRAN', 5),
(642, 'TAMESIS', 5),
(643, 'BARBOSA', 5),
(644, 'TARAZA', 5),
(645, 'TARSO', 5),
(646, 'TITIRIBI', 5),
(647, 'TOLEDO', 5),
(648, 'TURBO', 5),
(649, 'URAMITA', 5),
(650, 'URRAO', 5),
(651, 'VALDIVIA', 5),
(652, 'VALPARAISO', 5),
(653, 'VEGACHI', 5),
(654, 'BELMIRA', 5),
(655, 'VENECIA', 5),
(656, 'VIGIA DEL FUERTE', 5),
(657, 'BELLO', 5),
(658, 'YALI', 5),
(659, 'YARUMAL', 5),
(660, 'YOLOMBO', 5),
(661, 'YONDO', 5),
(662, 'ZARAGOZA', 5),
(663, 'BETANIA', 5),
(664, 'BETULIA', 5),
(665, 'VILLAVICENCIO', 50),
(666, 'BARRANCA DE UPIA', 50),
(667, 'CABUYARO', 50),
(668, 'CASTILLA LA NUEVA', 50),
(669, 'CUBARRAL', 50),
(670, 'CUMARAL', 50),
(671, 'EL CALVARIO', 50),
(672, 'EL CASTILLO', 50),
(673, 'EL DORADO', 50),
(674, 'FUENTE DE ORO', 50),
(675, 'GRANADA', 50),
(676, 'GUAMAL', 50),
(677, 'MAPIRIPAN', 50),
(678, 'MESETAS', 50),
(679, 'LA MACARENA', 50),
(680, 'URIBE', 50),
(681, 'LEJANIAS', 50),
(682, 'PUERTO CONCORDIA', 50),
(683, 'PUERTO GAITAN', 50),
(684, 'PUERTO LOPEZ', 50),
(685, 'PUERTO LLERAS', 50),
(686, 'PUERTO RICO', 50),
(687, 'ACACIAS', 50),
(688, 'RESTREPO', 50),
(689, 'SAN CARLOS DE GUAROA', 50),
(690, 'SAN JUAN DE ARAMA', 50),
(691, 'SAN JUANITO', 50),
(692, 'SAN MARTIN', 50),
(693, 'VISTAHERMOSA', 50),
(694, 'PASTO', 52),
(695, 'BUESACO', 52),
(696, 'ALBAN', 52),
(697, 'COLON', 52),
(698, 'CONSACA', 52),
(699, 'CONTADERO', 52),
(700, 'CORDOBA', 52),
(701, 'ALDANA', 52),
(702, 'CUASPUD', 52),
(703, 'CUMBAL', 52),
(704, 'CUMBITARA', 52),
(705, 'CHACHAGUI', 52),
(706, 'EL CHARCO', 52),
(707, 'EL PEÑOL', 52),
(708, 'EL ROSARIO', 52),
(709, 'EL TABLON', 52),
(710, 'EL TABLON DE GOMEZ', 52),
(711, 'EL TAMBO', 52),
(712, 'FUNES', 52),
(713, 'GUACHUCAL', 52),
(714, 'GUAITARILLA', 52),
(715, 'GUALMATAN', 52),
(716, 'ILES', 52),
(717, 'IMUES', 52),
(718, 'IPIALES', 52),
(719, 'ANCUYA', 52),
(720, 'LA CRUZ', 52),
(721, 'LA FLORIDA', 52),
(722, 'LA LLANADA', 52),
(723, 'LA TOLA', 52),
(724, 'LA UNION', 52),
(725, 'LEIVA', 52),
(726, 'LINARES', 52),
(727, 'LOS ANDES', 52),
(728, 'MAGUI', 52),
(729, 'MALLAMA', 52),
(730, 'MOSQUERA', 52),
(731, 'NARIÑO', 52),
(732, 'OLAYA HERRERA', 52),
(733, 'OSPINA', 52),
(734, 'ARBOLEDA', 52),
(735, 'ARBOLEDA (BERRUECOS)', 52),
(736, 'FRANCISCO PIZARRO', 52),
(737, 'POLICARPA', 52),
(738, 'POTOSI', 52),
(739, 'PROVIDENCIA', 52),
(740, 'PUERRES', 52),
(741, 'PUPIALES', 52),
(742, 'RICAURTE', 52),
(743, 'ROBERTO PAYAN', 52),
(744, 'SAMANIEGO', 52),
(745, 'SANDONA', 52),
(746, 'SAN BERNARDO', 52),
(747, 'SAN LORENZO', 52),
(748, 'SAN PABLO', 52),
(749, 'SAN PEDRO DE CARTAGO', 52),
(750, 'SANTA BARBARA', 52),
(751, 'SANTACRUZ', 52),
(752, 'SAPUYES', 52),
(753, 'TAMINANGO', 52),
(754, 'TANGUA', 52),
(755, 'BARBACOAS', 52),
(756, 'BELEN', 52),
(757, 'TUMACO', 52),
(758, 'TUQUERRES', 52),
(759, 'YACUANQUER', 52),
(760, 'CUCUTA', 54),
(761, 'BUCARASICA', 54),
(762, 'CACOTA', 54),
(763, 'CACHIRA', 54),
(764, 'CHINACOTA', 54),
(765, 'CHITAGA', 54),
(766, 'CONVENCION', 54),
(767, 'CUCUTILLA', 54),
(768, 'DURANIA', 54),
(769, 'EL CARMEN', 54),
(770, 'EL TARRA', 54),
(771, 'EL ZULIA', 54),
(772, 'ABREGO', 54),
(773, 'GRAMALOTE', 54),
(774, 'HACARI', 54),
(775, 'HERRAN', 54),
(776, 'LABATECA', 54),
(777, 'LA ESPERANZA', 54),
(778, 'LA PLAYA', 54),
(779, 'LOS PATIOS', 54),
(780, 'LOURDES', 54),
(781, 'MUTISCUA', 54),
(782, 'OCAÑA', 54),
(783, 'ARBOLEDAS', 54),
(784, 'PAMPLONA', 54),
(785, 'PAMPLONITA', 54),
(786, 'PUERTO SANTANDER', 54),
(787, 'RAGONVALIA', 54),
(788, 'SALAZAR', 54),
(789, 'SAN CALIXTO', 54),
(790, 'SAN CAYETANO', 54),
(791, 'SANTIAGO', 54),
(792, 'SARDINATA', 54),
(793, 'SILOS', 54),
(794, 'TEORAMA', 54),
(795, 'TIBU', 54),
(796, 'TOLEDO', 54),
(797, 'VILLA CARO', 54),
(798, 'VILLA DEL ROSARIO', 54),
(799, 'BOCHALEMA', 54),
(800, 'ARMENIA', 63),
(801, 'BUENAVISTA', 63),
(802, 'CALARCA', 63),
(803, 'CIRCASIA', 63),
(804, 'CORDOBA', 63),
(805, 'FILANDIA', 63),
(806, 'GENOVA', 63),
(807, 'LA TEBAIDA', 63),
(808, 'MONTENEGRO', 63),
(809, 'PIJAO', 63),
(810, 'QUIMBAYA', 63),
(811, 'SALENTO', 63),
(812, 'PEREIRA', 66),
(813, 'DOS QUEBRADAS', 66),
(814, 'GUATICA', 66),
(815, 'LA CELIA', 66),
(816, 'LA VIRGINIA', 66),
(817, 'MARSELLA', 66),
(818, 'APIA', 66),
(819, 'MISTRATO', 66),
(820, 'PUEBLO RICO', 66),
(821, 'QUINCHIA', 66),
(822, 'SANTA ROSA DE CABAL', 66),
(823, 'SANTUARIO', 66),
(824, 'BALBOA', 66),
(825, 'BELEN DE UMBRIA', 66),
(826, 'BUCARAMANGA', 68),
(827, 'BOLIVAR', 68),
(828, 'CABRERA', 68),
(829, 'AGUADA', 68),
(830, 'CALIFORNIA', 68),
(831, 'CAPITANEJO', 68),
(832, 'CARCASI', 68),
(833, 'CEPITA', 68),
(834, 'CERRITO', 68),
(835, 'CHARALA', 68),
(836, 'CHARTA', 68),
(837, 'CHIMA', 68),
(838, 'CHIPATA', 68),
(839, 'CIMITARRA', 68),
(840, 'ALBANIA', 68),
(841, 'CONCEPCION', 68),
(842, 'CONFINES', 68),
(843, 'CONTRATACION', 68),
(844, 'COROMORO', 68),
(845, 'CURITI', 68),
(846, 'EL CARMEN', 68),
(847, 'EL CARMEN DE CHUCURI', 68),
(848, 'EL GUACAMAYO', 68),
(849, 'EL PEÑON', 68),
(850, 'EL PLAYON', 68),
(851, 'ENCINO', 68),
(852, 'ENCISO', 68),
(853, 'FLORIAN', 68),
(854, 'FLORIDABLANCA', 68),
(855, 'GALAN', 68),
(856, 'GAMBITA', 68),
(857, 'GIRON', 68),
(858, 'GUACA', 68),
(859, 'GUADALUPE', 68),
(860, 'GUAPOTA', 68),
(861, 'GUAVATA', 68),
(862, 'GUEPSA', 68),
(863, 'HATO', 68),
(864, 'JESUS MARIA', 68),
(865, 'JORDAN', 68),
(866, 'LA BELLEZA', 68),
(867, 'LANDAZURI', 68),
(868, 'LA PAZ', 68),
(869, 'LEBRIJA', 68),
(870, 'LOS SANTOS', 68),
(871, 'MACARAVITA', 68),
(872, 'MALAGA', 68),
(873, 'MATANZA', 68),
(874, 'MOGOTES', 68),
(875, 'MOLAGAVITA', 68),
(876, 'OCAMONTE', 68),
(877, 'OIBA', 68),
(878, 'ONZAGA', 68),
(879, 'ARATOCA', 68),
(880, 'PALMAR', 68),
(881, 'PALMAS DEL SOCORRO', 68),
(882, 'PARAMO', 68),
(883, 'PIEDECUESTA', 68),
(884, 'PINCHOTE', 68),
(885, 'PUENTE NACIONAL', 68),
(886, 'PUERTO PARRA', 68),
(887, 'PUERTO WILCHES', 68),
(888, 'RIONEGRO', 68),
(889, 'SABANA DE TORRES', 68),
(890, 'SAN ANDRES', 68),
(891, 'SAN BENITO', 68),
(892, 'SAN GIL', 68),
(893, 'SAN JOAQUIN', 68),
(894, 'SAN JOSE DE MIRANDA', 68),
(895, 'SAN MIGUEL', 68),
(896, 'SAN VICENTE DE CHUCURI', 68),
(897, 'SANTA BARBARA', 68),
(898, 'SANTA HELENA DEL OPON', 68),
(899, 'SIMACOTA', 68),
(900, 'SOCORRO', 68),
(901, 'BARBOSA', 68),
(902, 'SUAITA', 68),
(903, 'SUCRE', 68),
(904, 'SURATA', 68),
(905, 'BARICHARA', 68),
(906, 'BARRANCABERMEJA', 68),
(907, 'TONA', 68),
(908, 'VALLE DE SAN JOSE', 68),
(909, 'VELEZ', 68),
(910, 'VETAS', 68),
(911, 'VILLANUEVA', 68),
(912, 'ZAPATOCA', 68),
(913, 'BETULIA', 68),
(914, 'SINCELEJO', 70),
(915, 'BUENAVISTA', 70),
(916, 'CAIMITO', 70),
(917, 'COLOSO', 70),
(918, 'COROZAL', 70),
(919, 'COVEÑAS', 70),
(920, 'CHALAN', 70),
(921, 'EL ROBLE', 70),
(922, 'GALERAS', 70),
(923, 'GUARANDA', 70),
(924, 'LA UNION', 70),
(925, 'LOS PALMITOS', 70),
(926, 'MAJAGUAL', 70),
(927, 'MORROA', 70),
(928, 'OVEJAS', 70),
(929, 'PALMITO', 70),
(930, 'SAMPUES', 70),
(931, 'SAN BENITO ABAD', 70),
(932, 'SAN JUAN DE BETULIA', 70),
(933, 'SAN MARCOS', 70),
(934, 'SAN ONOFRE', 70),
(935, 'SAN PEDRO', 70),
(936, 'SINCE', 70),
(937, 'SUCRE', 70),
(938, 'TOLU', 70),
(939, 'TOLU VIEJO', 70),
(940, 'IBAGUE', 73),
(941, 'CAJAMARCA', 73),
(942, 'CARMEN DE APICALA', 73),
(943, 'CASABIANCA', 73),
(944, 'CHAPARRAL', 73),
(945, 'COELLO', 73),
(946, 'COYAIMA', 73),
(947, 'CUNDAY', 73),
(948, 'DOLORES', 73),
(949, 'ALPUJARRA', 73),
(950, 'ALVARADO', 73),
(951, 'ESPINAL', 73),
(952, 'FALAN', 73),
(953, 'FLANDES', 73),
(954, 'FRESNO', 73),
(955, 'AMBALEMA', 73),
(956, 'GUAMO', 73),
(957, 'HERVEO', 73),
(958, 'HONDA', 73),
(959, 'ICONONZO', 73),
(960, 'LERIDA', 73),
(961, 'LIBANO', 73),
(962, 'ANZOATEGUI', 73),
(963, 'MARIQUITA', 73),
(964, 'MELGAR', 73),
(965, 'MURILLO', 73),
(966, 'NATAGAIMA', 73),
(967, 'ORTEGA', 73),
(968, 'PALOCABILDO', 73),
(969, 'PIEDRAS', 73),
(970, 'ARMERO', 73),
(971, 'PLANADAS', 73),
(972, 'PRADO', 73),
(973, 'PURIFICACION', 73),
(974, 'RIOBLANCO', 73),
(975, 'RONCESVALLES', 73),
(976, 'ROVIRA', 73),
(977, 'ATACO', 73),
(978, 'SALDAÑA', 73),
(979, 'SAN ANTONIO', 73),
(980, 'SAN LUIS', 73),
(981, 'SANTA ISABEL', 73),
(982, 'SUAREZ', 73),
(983, 'VALLE DE SAN JUAN', 73),
(984, 'VENADILLO', 73),
(985, 'VILLAHERMOSA', 73),
(986, 'VILLARRICA', 73),
(987, 'CALI', 76),
(988, 'BOLIVAR', 76),
(989, 'BUENAVENTURA', 76),
(990, 'BUGA', 76),
(991, 'BUGALAGRANDE', 76),
(992, 'CAICEDONIA', 76),
(993, 'CALIMA', 76),
(994, 'CANDELARIA', 76),
(995, 'CARTAGO', 76),
(996, 'ALCALA', 76),
(997, 'DAGUA', 76),
(998, 'EL AGUILA', 76),
(999, 'EL CAIRO', 76),
(1000, 'EL CERRITO', 76),
(1001, 'EL DOVIO', 76),
(1002, 'FLORIDA', 76),
(1003, 'GINEBRA', 76),
(1004, 'GUACARI', 76),
(1005, 'ANDALUCIA', 76),
(1006, 'JAMUNDI', 76),
(1007, 'LA CUMBRE', 76),
(1008, 'LA UNION', 76),
(1009, 'LA VICTORIA', 76),
(1010, 'ANSERMANUEVO', 76),
(1011, 'OBANDO', 76),
(1012, 'PALMIRA', 76),
(1013, 'ARGELIA', 76),
(1014, 'PRADERA', 76),
(1015, 'RESTREPO', 76),
(1016, 'RIOFRIO', 76),
(1017, 'ROLDANILLO', 76),
(1018, 'SAN PEDRO', 76),
(1019, 'SEVILLA', 76),
(1020, 'TORO', 76),
(1021, 'TRUJILLO', 76),
(1022, 'TULUA', 76),
(1023, 'ULLOA', 76),
(1024, 'VERSALLES', 76),
(1025, 'VIJES', 76),
(1026, 'YOTOCO', 76),
(1027, 'YUMBO', 76),
(1028, 'ZARZAL', 76),
(1029, 'BARRANQUILLA', 8),
(1030, 'CAMPO DE LA CRUZ', 8),
(1031, 'CANDELARIA', 8),
(1032, 'GALAPA', 8),
(1033, 'JUAN DE ACOSTA', 8),
(1034, 'LURUACO', 8),
(1035, 'MALAMBO', 8),
(1036, 'MANATI', 8),
(1037, 'PALMAR DE VARELA', 8),
(1038, 'PIOJO', 8),
(1039, 'POLONUEVO', 8),
(1040, 'PONEDERA', 8),
(1041, 'PUERTO COLOMBIA', 8),
(1042, 'REPELON', 8),
(1043, 'SABANAGRANDE', 8),
(1044, 'SABANALARGA', 8),
(1045, 'SANTA LUCIA', 8),
(1046, 'SANTO TOMAS', 8),
(1047, 'SOLEDAD', 8),
(1048, 'SUAN', 8),
(1049, 'BARANOA', 8),
(1050, 'TUBARA', 8),
(1051, 'USIACURI', 8),
(1052, 'ARAUCA', 81),
(1053, 'CRAVO NORTE', 81),
(1054, 'FORTUL', 81),
(1055, 'PUERTO RONDON', 81),
(1056, 'ARAUQUITA', 81),
(1057, 'SARAVENA', 81),
(1058, 'TAME', 81),
(1059, 'YOPAL', 85),
(1060, 'AGUAZUL', 85),
(1061, 'HATO COROZAL', 85),
(1062, 'LA SALINA', 85),
(1063, 'MANI', 85),
(1064, 'CHAMEZA', 85),
(1065, 'MONTERREY', 85),
(1066, 'NUNCHIA', 85),
(1067, 'OROCUE', 85),
(1068, 'PAZ DE ARIPORO', 85),
(1069, 'PORE', 85),
(1070, 'RECETOR', 85),
(1071, 'SABANALARGA', 85),
(1072, 'SACAMA', 85),
(1073, 'SAN LUIS DE PALENQUE', 85),
(1074, 'TAMARA', 85),
(1075, 'TAURAMENA', 85),
(1076, 'TRINIDAD', 85),
(1077, 'VILLANUEVA', 85),
(1078, 'MOCOA', 86),
(1079, 'COLON', 86),
(1080, 'ORITO', 86),
(1081, 'PUERTO ASIS', 86),
(1082, 'PUERTO CAICEDO', 86),
(1083, 'PUERTO GUZMAN', 86),
(1084, 'LEGUIZAMO', 86),
(1085, 'SIBUNDOY', 86),
(1086, 'SAN FRANCISCO', 86),
(1087, 'SAN MIGUEL', 86),
(1088, 'SANTIAGO', 86),
(1089, 'VALLE DEL GUAMUEZ', 86),
(1090, 'VILLAGARZON', 86),
(1091, 'SAN ANDRES', 88),
(1092, 'PROVIDENCIA', 88),
(1093, 'LETICIA', 91),
(1094, 'EL ENCANTO', 91),
(1095, 'LA CHORRERA', 91),
(1096, 'LA PEDRERA', 91),
(1097, 'LA VICTORIA', 91),
(1098, 'MIRITI - PARANA', 91),
(1099, 'PUERTO ALEGRIA', 91),
(1100, 'PUERTO ARICA', 91),
(1101, 'PUERTO NARIÑO', 91),
(1102, 'PUERTO SANTANDER', 91),
(1103, 'TARAPACA', 91),
(1104, 'INIRIDA', 94),
(1105, 'BARRANCO MINAS', 94),
(1106, 'MAPIRIPANA', 94),
(1107, 'SAN FELIPE', 94),
(1108, 'PUERTO COLOMBIA', 94),
(1109, 'LA GUADALUPE', 94),
(1110, 'CACAHUAL', 94),
(1111, 'PANA PANA', 94),
(1112, 'MORICHAL', 94),
(1113, 'SAN JOSE DEL GUAVIARE', 95),
(1114, 'CALAMAR', 95),
(1115, 'MIRAFLORES', 95),
(1116, 'EL RETORNO', 95),
(1117, 'MITU', 97),
(1118, 'CARURU', 97),
(1119, 'PACOA', 97),
(1120, 'TARAIRA', 97),
(1121, 'PAPUNAUA', 97),
(1122, 'YAVARATE', 97),
(1123, 'PUERTO CARREÑO', 99),
(1124, 'LA PRIMAVERA', 99),
(1125, 'SANTA ROSALIA', 99),
(1126, 'CUMARIBO', 99),
(1127, 'LIMA', 580),
(1128, 'GUATEMALA', 590),
(1129, 'Sao Paulo', 600),
(1130, 'U.S.A.', 700),
(1131, 'Ciudad de Mexico', 710),
(1132, 'Santiago de Chile', 720),
(1133, 'Buenos Aires', 730),
(1134, 'CARACAS', 740),
(1135, 'La paz Bolivia', 750),
(1136, 'Switzerland', 770),
(1137, 'Quito', 800),
(1138, 'Madrid', 810),
(1139, 'MIAMI', 7001),
(1140, 'CHICAGO', 7002),
(1141, 'OAK BROOK', 7002),
(1142, 'HINSDALE', 7002),
(1143, 'PETIT LANCY', 770);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_paises`
--

CREATE TABLE `tb_paises` (
  `id_pais` int(5) NOT NULL,
  `pais` varchar(60) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tb_paises`
--

INSERT INTO `tb_paises` (`id_pais`, `pais`) VALUES
(1, 'default'),
(57, 'COLOMBIA'),
(58, 'PERU'),
(59, 'GUATEMALA'),
(70, 'U.S.A.'),
(71, 'Mexico DF'),
(72, 'Chile'),
(73, 'Argentina'),
(74, 'VENEZUELA'),
(75, 'BOLIVIA'),
(77, 'Switzerland'),
(80, 'ECUADOR'),
(81, 'España'),
(600, 'BRASIL');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_peticiones`
--

CREATE TABLE `tb_peticiones` (
  `id_peticiones` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `fecha_peticion` datetime NOT NULL,
  `peticion` varchar(1000) NOT NULL,
  `estado_peticion` int(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_ranking`
--

CREATE TABLE `tb_ranking` (
  `id_ranking` int(11) NOT NULL,
  `id_tipo_ranking` int(11) NOT NULL,
  `puesto_1` int(11) NOT NULL,
  `puesto_2` int(11) NOT NULL,
  `puesto_3` int(11) NOT NULL,
  `fecha_ranking` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_tipo_like`
--

CREATE TABLE `tb_tipo_like` (
  `id_tipo_like` int(11) NOT NULL,
  `tipo_like` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tb_tipo_like`
--

INSERT INTO `tb_tipo_like` (`id_tipo_like`, `tipo_like`) VALUES
(1, 'like'),
(2, 'dis_like');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_tipo_ranking`
--

CREATE TABLE `tb_tipo_ranking` (
  `id_tipo_ranking` int(11) NOT NULL,
  `tipo_ranking` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_tipo_usuario`
--

CREATE TABLE `tb_tipo_usuario` (
  `id_tipo_usuario` int(11) NOT NULL,
  `tipo_usuario` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tb_tipo_usuario`
--

INSERT INTO `tb_tipo_usuario` (`id_tipo_usuario`, `tipo_usuario`) VALUES
(1, 'lector'),
(2, 'autor'),
(3, 'administador');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_usuarios`
--

CREATE TABLE `tb_usuarios` (
  `id_usuario` int(11) NOT NULL,
  `nombres` varchar(50) NOT NULL,
  `apellidos` varchar(50) NOT NULL,
  `usuario` varchar(13) NOT NULL,
  `correo` varchar(70) NOT NULL,
  `telefono` varchar(16) NOT NULL,
  `clave` varchar(300) NOT NULL,
  `id_pais` int(5) NOT NULL,
  `id_estado` int(5) NOT NULL,
  `id_mcpio` int(11) NOT NULL,
  `id_tipo_usuario` int(11) NOT NULL,
  `fecha_registro` datetime NOT NULL,
  `foto_perfil` varchar(300) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tb_usuarios`
--

INSERT INTO `tb_usuarios` (`id_usuario`, `nombres`, `apellidos`, `usuario`, `correo`, `telefono`, `clave`, `id_pais`, `id_estado`, `id_mcpio`, `id_tipo_usuario`, `fecha_registro`, `foto_perfil`) VALUES
(12, 'cristian david', 'engo crida', 'Enciso Crida', 'cridaengo1209@gmail.com', '837483473847', '$2y$10$zwFpQmjbjQxCnaBoRruF3OQEtRtpbnvLlpBQs2MFufrG8gcQiQftq', 57, 63, 811, 2, '2021-03-25 17:24:33', 'fotoPerfil/1618004488_uchiha-brothers-❤-4k-hd-desktop-wallpaper-for-4k-ultra-hd-tv.jpg'),
(13, 'david engo', 'iamo', 'EncisoCrid', 'lolol@gmail.com', '23343434', '$2y$10$/uAqkuEr3ckN8qARxQ/a6udsbpdf4FIMoM52iKbBmpxQqbe5kDyxa', 59, 590, 1128, 2, '2021-03-25 21:28:24', 'fotoPerfil/1616786042_OIP.jpg'),
(14, 'jhony alexander ', 'garcia cardenas ', 'kaleth zk', 'jhony@holmail.com', '3204534813', '$2y$10$nyHCv/QWXtiAqmso327cfukDCEe0a4.1y6rjmdYdWNIeYYtiw/nQ2', 57, 15, 49, 1, '2021-03-29 12:33:59', 'fotoPerfil/1617039341_OIP.jpg'),
(15, 'pueba ', 'pruebas', 'usuario pru', 'prueba@gmail.com', '34343434', '$2y$10$VZ9HBUl18r2P7uxldrZitO/6fszeHfcTpp9SsP5hq6myKsD56woy6', 57, 95, 1114, 1, '2021-04-09 16:23:22', 'fotoPerfil/img-perfil-default.png');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_videos`
--

CREATE TABLE `tb_videos` (
  `id` int(11) NOT NULL,
  `autor` varchar(30) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `caratula` varchar(300) NOT NULL,
  `resena` varchar(1000) NOT NULL,
  `archivo` varchar(100) NOT NULL,
  `id_categoria` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `fecha_registro` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vi_usuarios`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vi_usuarios` (
`nombres` varchar(50)
,`apellidos` varchar(50)
,`pais` varchar(60)
,`estado` varchar(60)
,`nombre_mcpio` varchar(60)
,`foto_perfil` varchar(300)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vi_usuarios_1`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vi_usuarios_1` (
`nombres` varchar(50)
,`apellidos` varchar(50)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vi_usuarios_2`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vi_usuarios_2` (
`correo` varchar(70)
,`foto_perfil` varchar(300)
);

-- --------------------------------------------------------

--
-- Estructura para la vista `vi_usuarios`
--
DROP TABLE IF EXISTS `vi_usuarios`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vi_usuarios`  AS SELECT `tb_usuarios`.`nombres` AS `nombres`, `tb_usuarios`.`apellidos` AS `apellidos`, `t1`.`pais` AS `pais`, `t2`.`estado` AS `estado`, `t3`.`nombre_mcpio` AS `nombre_mcpio`, `tb_usuarios`.`foto_perfil` AS `foto_perfil` FROM (((`tb_usuarios` join `tb_paises` `t1`) join `tb_estados` `t2`) join `tb_municipios` `t3`) ;

-- --------------------------------------------------------

--
-- Estructura para la vista `vi_usuarios_1`
--
DROP TABLE IF EXISTS `vi_usuarios_1`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vi_usuarios_1`  AS SELECT `tb_usuarios`.`nombres` AS `nombres`, `tb_usuarios`.`apellidos` AS `apellidos` FROM `tb_usuarios` ;

-- --------------------------------------------------------

--
-- Estructura para la vista `vi_usuarios_2`
--
DROP TABLE IF EXISTS `vi_usuarios_2`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vi_usuarios_2`  AS SELECT `tb_usuarios`.`correo` AS `correo`, `tb_usuarios`.`foto_perfil` AS `foto_perfil` FROM `tb_usuarios` ;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `tb_audios`
--
ALTER TABLE `tb_audios`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nombre` (`nombre`),
  ADD UNIQUE KEY `archivo` (`archivo`),
  ADD KEY `audio_categoria` (`id_categoria`),
  ADD KEY `audio_usuario` (`id_usuario`);

--
-- Indices de la tabla `tb_categorias`
--
ALTER TABLE `tb_categorias`
  ADD PRIMARY KEY (`id_categoria`);

--
-- Indices de la tabla `tb_comentarios`
--
ALTER TABLE `tb_comentarios`
  ADD PRIMARY KEY (`id_comentario`),
  ADD KEY `comentario_usuario` (`id_usuario`);

--
-- Indices de la tabla `tb_comentarios_audios`
--
ALTER TABLE `tb_comentarios_audios`
  ADD PRIMARY KEY (`id_comentario`),
  ADD KEY `tb_comentarios_audios` (`id_usuario`),
  ADD KEY `tb_comentarios_audios_publicacion` (`id_publicacion`);

--
-- Indices de la tabla `tb_comentarios_comics`
--
ALTER TABLE `tb_comentarios_comics`
  ADD PRIMARY KEY (`id_comentario`),
  ADD KEY `tb_comentarios_comics` (`id_usuario`),
  ADD KEY `tb_comentarios_comics_publicacion` (`id_publicacion`);

--
-- Indices de la tabla `tb_comentarios_imagenes`
--
ALTER TABLE `tb_comentarios_imagenes`
  ADD PRIMARY KEY (`id_comentario`),
  ADD KEY `tb_comentarios_imagenes` (`id_usuario`),
  ADD KEY `tb_comentarios_imagenes_publicacion` (`id_publicacion`);

--
-- Indices de la tabla `tb_comentarios_libros`
--
ALTER TABLE `tb_comentarios_libros`
  ADD PRIMARY KEY (`id_comentario`),
  ADD KEY `tb_comentarios_libros` (`id_usuario`),
  ADD KEY `tb_comentarios_libros_publicacion` (`id_publicacion`);

--
-- Indices de la tabla `tb_comentarios_videos`
--
ALTER TABLE `tb_comentarios_videos`
  ADD PRIMARY KEY (`id_comentario`),
  ADD KEY `tb_comentarios_videos` (`id_usuario`),
  ADD KEY `tb_comentarios_videos_publicacion` (`id_publicacion`);

--
-- Indices de la tabla `tb_comics`
--
ALTER TABLE `tb_comics`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nombre` (`nombre`),
  ADD UNIQUE KEY `archivo` (`archivo`),
  ADD KEY `comics_categoria` (`id_categoria`),
  ADD KEY `comics_usuario` (`id_usuario`);

--
-- Indices de la tabla `tb_compras`
--
ALTER TABLE `tb_compras`
  ADD PRIMARY KEY (`id_compra`),
  ADD KEY `compra_usuario` (`id_usuario`);

--
-- Indices de la tabla `tb_dislikes_audios`
--
ALTER TABLE `tb_dislikes_audios`
  ADD PRIMARY KEY (`id_like`),
  ADD KEY `dislike_audios` (`id_usuario`);

--
-- Indices de la tabla `tb_dislikes_comics`
--
ALTER TABLE `tb_dislikes_comics`
  ADD PRIMARY KEY (`id_like`),
  ADD KEY `dislike_comics` (`id_usuario`);

--
-- Indices de la tabla `tb_dislikes_imagenes`
--
ALTER TABLE `tb_dislikes_imagenes`
  ADD PRIMARY KEY (`id_like`),
  ADD KEY `dislike_imagenes` (`id_usuario`);

--
-- Indices de la tabla `tb_dislikes_libros`
--
ALTER TABLE `tb_dislikes_libros`
  ADD PRIMARY KEY (`id_like`),
  ADD KEY `dislike_libros` (`id_usuario`);

--
-- Indices de la tabla `tb_dislikes_videos`
--
ALTER TABLE `tb_dislikes_videos`
  ADD PRIMARY KEY (`id_like`),
  ADD KEY `dislike_videos` (`id_usuario`);

--
-- Indices de la tabla `tb_estados`
--
ALTER TABLE `tb_estados`
  ADD PRIMARY KEY (`id_estado`),
  ADD KEY `estado_pais` (`id_pais`);

--
-- Indices de la tabla `tb_favoritos`
--
ALTER TABLE `tb_favoritos`
  ADD PRIMARY KEY (`id_favorito`),
  ADD KEY `favorito_usuaeio` (`id_usuario`);

--
-- Indices de la tabla `tb_imagenes`
--
ALTER TABLE `tb_imagenes`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nombre` (`nombre`),
  ADD UNIQUE KEY `archivo` (`archivo`),
  ADD KEY `imagene_categoria` (`id_categoria`),
  ADD KEY `imagene_usuario` (`id_usuario`);

--
-- Indices de la tabla `tb_libros`
--
ALTER TABLE `tb_libros`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nombre` (`nombre`),
  ADD UNIQUE KEY `archivo` (`archivo`);

--
-- Indices de la tabla `tb_likes_audios`
--
ALTER TABLE `tb_likes_audios`
  ADD PRIMARY KEY (`id_like`),
  ADD KEY `like_audios` (`id_usuario`);

--
-- Indices de la tabla `tb_likes_comics`
--
ALTER TABLE `tb_likes_comics`
  ADD PRIMARY KEY (`id_like`),
  ADD KEY `like_comics` (`id_usuario`);

--
-- Indices de la tabla `tb_likes_imagenes`
--
ALTER TABLE `tb_likes_imagenes`
  ADD PRIMARY KEY (`id_like`),
  ADD KEY `like_imagenes` (`id_usuario`);

--
-- Indices de la tabla `tb_likes_libros`
--
ALTER TABLE `tb_likes_libros`
  ADD PRIMARY KEY (`id_like`),
  ADD KEY `like_libros` (`id_usuario`);

--
-- Indices de la tabla `tb_likes_videos`
--
ALTER TABLE `tb_likes_videos`
  ADD PRIMARY KEY (`id_like`),
  ADD KEY `like_videos` (`id_usuario`);

--
-- Indices de la tabla `tb_mendajes`
--
ALTER TABLE `tb_mendajes`
  ADD PRIMARY KEY (`id_mensaje`),
  ADD KEY `mendaje_usuaeio` (`id_usuario`);

--
-- Indices de la tabla `tb_monedas`
--
ALTER TABLE `tb_monedas`
  ADD PRIMARY KEY (`id_moneda`),
  ADD KEY `modenadas_usuario` (`id_usuario`);

--
-- Indices de la tabla `tb_municipios`
--
ALTER TABLE `tb_municipios`
  ADD PRIMARY KEY (`id_mcpio`),
  ADD KEY `estado_municipio` (`id_estado`);

--
-- Indices de la tabla `tb_paises`
--
ALTER TABLE `tb_paises`
  ADD PRIMARY KEY (`id_pais`);

--
-- Indices de la tabla `tb_peticiones`
--
ALTER TABLE `tb_peticiones`
  ADD PRIMARY KEY (`id_peticiones`),
  ADD KEY `peticion_usuaeio` (`id_usuario`);

--
-- Indices de la tabla `tb_ranking`
--
ALTER TABLE `tb_ranking`
  ADD PRIMARY KEY (`id_ranking`),
  ADD KEY `tipo_rankink` (`id_tipo_ranking`);

--
-- Indices de la tabla `tb_tipo_like`
--
ALTER TABLE `tb_tipo_like`
  ADD PRIMARY KEY (`id_tipo_like`);

--
-- Indices de la tabla `tb_tipo_ranking`
--
ALTER TABLE `tb_tipo_ranking`
  ADD PRIMARY KEY (`id_tipo_ranking`);

--
-- Indices de la tabla `tb_tipo_usuario`
--
ALTER TABLE `tb_tipo_usuario`
  ADD PRIMARY KEY (`id_tipo_usuario`);

--
-- Indices de la tabla `tb_usuarios`
--
ALTER TABLE `tb_usuarios`
  ADD PRIMARY KEY (`id_usuario`),
  ADD UNIQUE KEY `usuario` (`usuario`),
  ADD UNIQUE KEY `correo` (`correo`),
  ADD KEY `usuario_pais` (`id_pais`),
  ADD KEY `usuario_departamento` (`id_estado`),
  ADD KEY `usuario_ciudad` (`id_mcpio`),
  ADD KEY `tipo_de_usuario` (`id_tipo_usuario`);

--
-- Indices de la tabla `tb_videos`
--
ALTER TABLE `tb_videos`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nombre` (`nombre`),
  ADD UNIQUE KEY `archivo` (`archivo`),
  ADD KEY `video_categoria` (`id_categoria`),
  ADD KEY `video_usuario` (`id_usuario`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `tb_audios`
--
ALTER TABLE `tb_audios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tb_categorias`
--
ALTER TABLE `tb_categorias`
  MODIFY `id_categoria` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `tb_comentarios`
--
ALTER TABLE `tb_comentarios`
  MODIFY `id_comentario` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tb_comentarios_audios`
--
ALTER TABLE `tb_comentarios_audios`
  MODIFY `id_comentario` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tb_comentarios_comics`
--
ALTER TABLE `tb_comentarios_comics`
  MODIFY `id_comentario` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tb_comentarios_imagenes`
--
ALTER TABLE `tb_comentarios_imagenes`
  MODIFY `id_comentario` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tb_comentarios_libros`
--
ALTER TABLE `tb_comentarios_libros`
  MODIFY `id_comentario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;

--
-- AUTO_INCREMENT de la tabla `tb_comentarios_videos`
--
ALTER TABLE `tb_comentarios_videos`
  MODIFY `id_comentario` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tb_comics`
--
ALTER TABLE `tb_comics`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tb_compras`
--
ALTER TABLE `tb_compras`
  MODIFY `id_compra` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tb_dislikes_audios`
--
ALTER TABLE `tb_dislikes_audios`
  MODIFY `id_like` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tb_dislikes_comics`
--
ALTER TABLE `tb_dislikes_comics`
  MODIFY `id_like` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tb_dislikes_imagenes`
--
ALTER TABLE `tb_dislikes_imagenes`
  MODIFY `id_like` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tb_dislikes_libros`
--
ALTER TABLE `tb_dislikes_libros`
  MODIFY `id_like` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=207;

--
-- AUTO_INCREMENT de la tabla `tb_dislikes_videos`
--
ALTER TABLE `tb_dislikes_videos`
  MODIFY `id_like` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tb_favoritos`
--
ALTER TABLE `tb_favoritos`
  MODIFY `id_favorito` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tb_imagenes`
--
ALTER TABLE `tb_imagenes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT de la tabla `tb_libros`
--
ALTER TABLE `tb_libros`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT de la tabla `tb_likes_audios`
--
ALTER TABLE `tb_likes_audios`
  MODIFY `id_like` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tb_likes_comics`
--
ALTER TABLE `tb_likes_comics`
  MODIFY `id_like` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tb_likes_imagenes`
--
ALTER TABLE `tb_likes_imagenes`
  MODIFY `id_like` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tb_likes_libros`
--
ALTER TABLE `tb_likes_libros`
  MODIFY `id_like` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=307;

--
-- AUTO_INCREMENT de la tabla `tb_likes_videos`
--
ALTER TABLE `tb_likes_videos`
  MODIFY `id_like` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tb_mendajes`
--
ALTER TABLE `tb_mendajes`
  MODIFY `id_mensaje` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tb_monedas`
--
ALTER TABLE `tb_monedas`
  MODIFY `id_moneda` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tb_peticiones`
--
ALTER TABLE `tb_peticiones`
  MODIFY `id_peticiones` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tb_ranking`
--
ALTER TABLE `tb_ranking`
  MODIFY `id_ranking` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tb_tipo_ranking`
--
ALTER TABLE `tb_tipo_ranking`
  MODIFY `id_tipo_ranking` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tb_tipo_usuario`
--
ALTER TABLE `tb_tipo_usuario`
  MODIFY `id_tipo_usuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `tb_usuarios`
--
ALTER TABLE `tb_usuarios`
  MODIFY `id_usuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT de la tabla `tb_videos`
--
ALTER TABLE `tb_videos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `tb_audios`
--
ALTER TABLE `tb_audios`
  ADD CONSTRAINT `audio_categoria` FOREIGN KEY (`id_categoria`) REFERENCES `tb_categorias` (`id_categoria`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `audio_usuario` FOREIGN KEY (`id_usuario`) REFERENCES `tb_usuarios` (`id_usuario`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `tb_comentarios`
--
ALTER TABLE `tb_comentarios`
  ADD CONSTRAINT `comentario_usuario` FOREIGN KEY (`id_usuario`) REFERENCES `tb_usuarios` (`id_usuario`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `tb_comentarios_audios`
--
ALTER TABLE `tb_comentarios_audios`
  ADD CONSTRAINT `tb_comentarios_audios` FOREIGN KEY (`id_usuario`) REFERENCES `tb_usuarios` (`id_usuario`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `tb_comentarios_audios_publicacion` FOREIGN KEY (`id_publicacion`) REFERENCES `tb_audios` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `tb_comentarios_comics`
--
ALTER TABLE `tb_comentarios_comics`
  ADD CONSTRAINT `tb_comentarios_comics` FOREIGN KEY (`id_usuario`) REFERENCES `tb_usuarios` (`id_usuario`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `tb_comentarios_comics_publicacion` FOREIGN KEY (`id_publicacion`) REFERENCES `tb_comics` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `tb_comentarios_imagenes`
--
ALTER TABLE `tb_comentarios_imagenes`
  ADD CONSTRAINT `tb_comentarios_imagenes` FOREIGN KEY (`id_usuario`) REFERENCES `tb_usuarios` (`id_usuario`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `tb_comentarios_imagenes_publicacion` FOREIGN KEY (`id_publicacion`) REFERENCES `tb_imagenes` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `tb_comentarios_libros`
--
ALTER TABLE `tb_comentarios_libros`
  ADD CONSTRAINT `tb_comentarios_libros` FOREIGN KEY (`id_usuario`) REFERENCES `tb_usuarios` (`id_usuario`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `tb_comentarios_libros_publicacion` FOREIGN KEY (`id_publicacion`) REFERENCES `tb_libros` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `tb_comentarios_videos`
--
ALTER TABLE `tb_comentarios_videos`
  ADD CONSTRAINT `tb_comentarios_videos` FOREIGN KEY (`id_usuario`) REFERENCES `tb_usuarios` (`id_usuario`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `tb_comentarios_videos_publicacion` FOREIGN KEY (`id_publicacion`) REFERENCES `tb_videos` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `tb_comics`
--
ALTER TABLE `tb_comics`
  ADD CONSTRAINT `comics_categoria` FOREIGN KEY (`id_categoria`) REFERENCES `tb_categorias` (`id_categoria`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `comics_usuario` FOREIGN KEY (`id_usuario`) REFERENCES `tb_usuarios` (`id_usuario`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `tb_compras`
--
ALTER TABLE `tb_compras`
  ADD CONSTRAINT `compra_usuario` FOREIGN KEY (`id_usuario`) REFERENCES `tb_usuarios` (`id_usuario`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `tb_dislikes_audios`
--
ALTER TABLE `tb_dislikes_audios`
  ADD CONSTRAINT `dislike_audios` FOREIGN KEY (`id_usuario`) REFERENCES `tb_usuarios` (`id_usuario`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `tb_dislikes_comics`
--
ALTER TABLE `tb_dislikes_comics`
  ADD CONSTRAINT `dislike_comics` FOREIGN KEY (`id_usuario`) REFERENCES `tb_usuarios` (`id_usuario`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `tb_dislikes_imagenes`
--
ALTER TABLE `tb_dislikes_imagenes`
  ADD CONSTRAINT `dislike_imagenes` FOREIGN KEY (`id_usuario`) REFERENCES `tb_usuarios` (`id_usuario`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `tb_dislikes_libros`
--
ALTER TABLE `tb_dislikes_libros`
  ADD CONSTRAINT `dislike_libros` FOREIGN KEY (`id_usuario`) REFERENCES `tb_usuarios` (`id_usuario`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `tb_dislikes_videos`
--
ALTER TABLE `tb_dislikes_videos`
  ADD CONSTRAINT `dislike_videos` FOREIGN KEY (`id_usuario`) REFERENCES `tb_usuarios` (`id_usuario`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `tb_estados`
--
ALTER TABLE `tb_estados`
  ADD CONSTRAINT `estado_pais` FOREIGN KEY (`id_pais`) REFERENCES `tb_paises` (`id_pais`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `tb_favoritos`
--
ALTER TABLE `tb_favoritos`
  ADD CONSTRAINT `favorito_usuaeio` FOREIGN KEY (`id_usuario`) REFERENCES `tb_usuarios` (`id_usuario`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `tb_imagenes`
--
ALTER TABLE `tb_imagenes`
  ADD CONSTRAINT `imagene_categoria` FOREIGN KEY (`id_categoria`) REFERENCES `tb_categorias` (`id_categoria`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `imagene_usuario` FOREIGN KEY (`id_usuario`) REFERENCES `tb_usuarios` (`id_usuario`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `tb_likes_audios`
--
ALTER TABLE `tb_likes_audios`
  ADD CONSTRAINT `like_audios` FOREIGN KEY (`id_usuario`) REFERENCES `tb_usuarios` (`id_usuario`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `tb_likes_comics`
--
ALTER TABLE `tb_likes_comics`
  ADD CONSTRAINT `like_comics` FOREIGN KEY (`id_usuario`) REFERENCES `tb_usuarios` (`id_usuario`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `tb_likes_imagenes`
--
ALTER TABLE `tb_likes_imagenes`
  ADD CONSTRAINT `like_imagenes` FOREIGN KEY (`id_usuario`) REFERENCES `tb_usuarios` (`id_usuario`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `tb_likes_libros`
--
ALTER TABLE `tb_likes_libros`
  ADD CONSTRAINT `like_libros` FOREIGN KEY (`id_usuario`) REFERENCES `tb_usuarios` (`id_usuario`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `tb_likes_videos`
--
ALTER TABLE `tb_likes_videos`
  ADD CONSTRAINT `like_videos` FOREIGN KEY (`id_usuario`) REFERENCES `tb_usuarios` (`id_usuario`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `tb_mendajes`
--
ALTER TABLE `tb_mendajes`
  ADD CONSTRAINT `mendaje_usuaeio` FOREIGN KEY (`id_usuario`) REFERENCES `tb_usuarios` (`id_usuario`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `tb_monedas`
--
ALTER TABLE `tb_monedas`
  ADD CONSTRAINT `modenadas_usuario` FOREIGN KEY (`id_usuario`) REFERENCES `tb_usuarios` (`id_usuario`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `tb_municipios`
--
ALTER TABLE `tb_municipios`
  ADD CONSTRAINT `estado_municipio` FOREIGN KEY (`id_estado`) REFERENCES `tb_estados` (`id_estado`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `tb_peticiones`
--
ALTER TABLE `tb_peticiones`
  ADD CONSTRAINT `peticion_usuaeio` FOREIGN KEY (`id_usuario`) REFERENCES `tb_usuarios` (`id_usuario`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `tb_ranking`
--
ALTER TABLE `tb_ranking`
  ADD CONSTRAINT `tipo_rankink` FOREIGN KEY (`id_tipo_ranking`) REFERENCES `tb_tipo_ranking` (`id_tipo_ranking`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `tb_usuarios`
--
ALTER TABLE `tb_usuarios`
  ADD CONSTRAINT `tipo_de_usuario` FOREIGN KEY (`id_tipo_usuario`) REFERENCES `tb_tipo_usuario` (`id_tipo_usuario`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `usuario_ciudad` FOREIGN KEY (`id_mcpio`) REFERENCES `tb_municipios` (`id_mcpio`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `usuario_departamento` FOREIGN KEY (`id_estado`) REFERENCES `tb_estados` (`id_estado`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `usuario_pais` FOREIGN KEY (`id_pais`) REFERENCES `tb_paises` (`id_pais`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `tb_videos`
--
ALTER TABLE `tb_videos`
  ADD CONSTRAINT `video_categoria` FOREIGN KEY (`id_categoria`) REFERENCES `tb_categorias` (`id_categoria`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `video_usuario` FOREIGN KEY (`id_usuario`) REFERENCES `tb_usuarios` (`id_usuario`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
