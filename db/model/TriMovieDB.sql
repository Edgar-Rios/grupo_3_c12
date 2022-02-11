-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versión del servidor:         10.1.38-MariaDB - mariadb.org binary distribution
-- SO del servidor:              Win32
-- HeidiSQL Versión:             11.3.0.6295
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Volcando estructura de base de datos para trimovie
CREATE DATABASE IF NOT EXISTS `trimovie` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `trimovie`;

-- Volcando estructura para tabla trimovie.actor
CREATE TABLE IF NOT EXISTS `actor` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL DEFAULT '',
  `last_name` varchar(50) NOT NULL DEFAULT '',
  `movie_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_actor_actor_movie` (`movie_id`),
  CONSTRAINT `FK_actor_actor_movie` FOREIGN KEY (`movie_id`) REFERENCES `actor_movie` (`actor_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla trimovie.actor_movie
CREATE TABLE IF NOT EXISTS `actor_movie` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `movie_id` int(11) NOT NULL,
  `actor_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id` (`id`),
  KEY `actor_id` (`actor_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla trimovie.genre
CREATE TABLE IF NOT EXISTS `genre` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category_name` varchar(50) NOT NULL DEFAULT '',
  `movie_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `movie_id` (`movie_id`),
  CONSTRAINT `movie_id` FOREIGN KEY (`movie_id`) REFERENCES `movie_genre` (`movie_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla trimovie.movie
CREATE TABLE IF NOT EXISTS `movie` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(50) NOT NULL,
  `description` varchar(500) NOT NULL,
  `actor` varchar(50) NOT NULL,
  `actor_id` int(11) NOT NULL,
  `genre` varchar(50) NOT NULL,
  `direction` varchar(50) NOT NULL,
  `duration` date NOT NULL,
  `genre_id` int(11) NOT NULL,
  `awards` int(11) DEFAULT NULL,
  `rating` int(11) DEFAULT NULL,
  `release_date` date NOT NULL,
  `price` int(10) unsigned NOT NULL,
  `shop_cart_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `FK_movie_movie_genre` (`genre_id`),
  KEY `FK_movie_actor_movie` (`actor_id`),
  KEY `FK_movie_movie_cart` (`shop_cart_id`),
  CONSTRAINT `FK_movie_actor_movie` FOREIGN KEY (`actor_id`) REFERENCES `actor_movie` (`actor_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_movie_movie_cart` FOREIGN KEY (`shop_cart_id`) REFERENCES `movie_cart` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_movie_movie_genre` FOREIGN KEY (`genre_id`) REFERENCES `movie_genre` (`genre_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla trimovie.movie_cart
CREATE TABLE IF NOT EXISTS `movie_cart` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `movie_id` int(10) unsigned NOT NULL DEFAULT '0',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `FK__user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla trimovie.movie_genre
CREATE TABLE IF NOT EXISTS `movie_genre` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `movie_id` int(11) NOT NULL,
  `genre_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `movie_id` (`movie_id`),
  KEY `genre_id` (`genre_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla trimovie.role
CREATE TABLE IF NOT EXISTS `role` (
  `id` int(10) unsigned NOT NULL,
  `admin` int(2) unsigned NOT NULL,
  `user` int(2) unsigned NOT NULL,
  `guest` int(2) unsigned NOT NULL,
  `user_id` int(2) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla trimovie.shop_cart
CREATE TABLE IF NOT EXISTS `shop_cart` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `movie_id` int(10) unsigned NOT NULL,
  `user_id` int(11) unsigned DEFAULT NULL,
  `movie_tltle` varchar(50) NOT NULL,
  `total` int(11) unsigned NOT NULL,
  `price` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_shop_cart_movie_cart` (`movie_id`),
  KEY `FK_shop_cart_movie_cart_2` (`user_id`),
  CONSTRAINT `FK_shop_cart_movie_cart` FOREIGN KEY (`movie_id`) REFERENCES `movie_cart` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_shop_cart_movie_cart_2` FOREIGN KEY (`user_id`) REFERENCES `movie_cart` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla trimovie.user
CREATE TABLE IF NOT EXISTS `user` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` tinytext NOT NULL,
  `last_name` tinytext NOT NULL,
  `email` varchar(50) NOT NULL,
  `avatar` varchar(50) NOT NULL,
  `address` varchar(50) NOT NULL,
  `favorite_movie` varchar(50) NOT NULL,
  `shop_cart_id` int(10) unsigned NOT NULL,
  `role` int(10) unsigned NOT NULL,
  `pass` bigint(20) unsigned NOT NULL,
  `bithdate` datetime NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `Email` (`email`) USING BTREE,
  KEY `FK_user_shop_cart` (`shop_cart_id`),
  KEY `FK_user_role` (`role`),
  CONSTRAINT `FK_user_role` FOREIGN KEY (`role`) REFERENCES `role` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_user_shop_cart` FOREIGN KEY (`shop_cart_id`) REFERENCES `shop_cart` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- La exportación de datos fue deseleccionada.

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
