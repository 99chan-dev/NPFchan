-- phpMyAdmin SQL Dump
-- version 4.7.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Jun 12, 2017 at 03:36 PM
-- Server version: 5.7.18-0ubuntu0.16.04.1
-- PHP Version: 7.0.18-0ubuntu0.16.04.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

-- --------------------------------------------------------

--
-- Table structure for table `announcements`
--

CREATE TABLE IF NOT EXISTS `announcements` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `creator` int(10) NOT NULL,
  `date` int(10) NOT NULL,
  `text` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `antispam`
--

CREATE TABLE IF NOT EXISTS `antispam` (
  `board` varchar(58) NOT NULL,
  `thread` int(11) DEFAULT NULL,
  `hash` char(40) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
  `created` int(11) NOT NULL,
  `expires` int(11) DEFAULT NULL,
  `passed` smallint(6) NOT NULL,
  PRIMARY KEY (`hash`),
  KEY `board` (`board`,`thread`),
  KEY `expires` (`expires`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `bans`
--

CREATE TABLE IF NOT EXISTS `bans` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `ipstart` varbinary(61) NOT NULL,
  `ipend` varchar(61) DEFAULT NULL,
  `cookie` varchar(40) CHARACTER SET ascii NOT NULL,
  `cookiebanned` tinyint(1) NOT NULL,
  `created` int(10) UNSIGNED NOT NULL,
  `expires` int(10) UNSIGNED DEFAULT NULL,
  `board` varchar(58) DEFAULT NULL,
  `creator` int(10) NOT NULL,
  `reason` text,
  `seen` tinyint(1) NOT NULL,
  `post` blob,
  PRIMARY KEY (`id`),
  KEY `expires` (`expires`),
  KEY `ipstart` (`ipstart`,`ipend`),
  KEY `cookie` (`cookie`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `bans_cookie`
--

CREATE TABLE IF NOT EXISTS `bans_cookie` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `cookie` varchar(40) CHARACTER SET ascii NOT NULL,
  `expires` int(11) NOT NULL,
  `creator` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  UNIQUE KEY `cookie` (`cookie`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `ban_appeals`
--

CREATE TABLE IF NOT EXISTS `ban_appeals` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `ban_id` int(10) UNSIGNED NOT NULL,
  `time` int(10) UNSIGNED NOT NULL,
  `message` text NOT NULL,
  `denied` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ban_id` (`ban_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `boards`
--

CREATE TABLE IF NOT EXISTS `boards` (
  `uri` varchar(58) NOT NULL,
  `title` tinytext NOT NULL,
  `subtitle` tinytext,
  PRIMARY KEY (`uri`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `boards`
--

INSERT INTO `boards` (`uri`, `title`, `subtitle`) VALUES
('b', 'Random', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `captchas`
--

CREATE TABLE IF NOT EXISTS `captchas` (
  `cookie` varchar(50) NOT NULL,
  `extra` varchar(200) NOT NULL,
  `text` varchar(255) DEFAULT NULL,
  `created_at` int(11) DEFAULT NULL,
  PRIMARY KEY (`cookie`,`extra`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `cites`
--

CREATE TABLE IF NOT EXISTS `cites` (
  `board` varchar(58) NOT NULL,
  `post` int(11) NOT NULL,
  `target_board` varchar(58) NOT NULL,
  `target` int(11) NOT NULL,
  KEY `target` (`target_board`,`target`),
  KEY `post` (`board`,`post`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `custom_geoip`
--

CREATE TABLE IF NOT EXISTS `custom_geoip` (
  `ip` varchar(61) CHARACTER SET ascii NOT NULL,
  `country` int(4) NOT NULL,
  UNIQUE KEY `ip` (`ip`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `filehashes`
--

CREATE TABLE IF NOT EXISTS `filehashes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `board` varchar(58) NOT NULL,
  `thread` int(11) NOT NULL,
  `post` int(11) NOT NULL,
  `filehash` text CHARACTER SET ascii NOT NULL,
  PRIMARY KEY (`id`),
  KEY `thread_id` (`thread`),
  KEY `post_id` (`post`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `flood`
--

CREATE TABLE IF NOT EXISTS `flood` (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `ip` varchar(61) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
  `board` varchar(58) NOT NULL,
  `time` int(11) NOT NULL,
  `posthash` char(32) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
  `filehash` char(32) CHARACTER SET ascii COLLATE ascii_bin DEFAULT NULL,
  `isreply` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ip` (`ip`),
  KEY `posthash` (`posthash`),
  KEY `filehash` (`filehash`),
  KEY `time` (`time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `ip_notes`
--

CREATE TABLE IF NOT EXISTS `ip_notes` (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `ip` varchar(61) CHARACTER SET ascii NOT NULL,
  `mod` int(11) DEFAULT NULL,
  `time` int(11) NOT NULL,
  `body` text NOT NULL,
  UNIQUE KEY `id` (`id`),
  KEY `ip_lookup` (`ip`,`time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `modlogs`
--

CREATE TABLE IF NOT EXISTS `modlogs` (
  `mod` int(11) NOT NULL,
  `ip` varchar(61) CHARACTER SET ascii NOT NULL,
  `board` varchar(58) DEFAULT NULL,
  `time` int(11) NOT NULL,
  `text` text NOT NULL,
  KEY `time` (`time`),
  KEY `mod` (`mod`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `mods`
--

CREATE TABLE IF NOT EXISTS `mods` (
  `id` smallint(6) UNSIGNED NOT NULL AUTO_INCREMENT,
  `username` varchar(30) NOT NULL,
  `password` varchar(256) CHARACTER SET ascii NOT NULL COMMENT 'SHA256',
  `version` varchar(64) CHARACTER SET ascii NOT NULL,
  `type` smallint(2) NOT NULL,
  `boards` text NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`,`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `mods`
--

INSERT INTO `mods` (`id`, `username`, `password`, `version`, `type`, `boards`) VALUES
(1, 'admin', 'cedad442efeef7112fed0f50b011b2b9bf83f6898082f995f69dd7865ca19fb7', '4a44c6c55df862ae901b413feecb0d49', 30, '*');

-- --------------------------------------------------------

--
-- Table structure for table `mutes`
--

CREATE TABLE IF NOT EXISTS `mutes` (
  `ip` varchar(61) CHARACTER SET ascii NOT NULL,
  `time` int(11) NOT NULL,
  KEY `ip` (`ip`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `news`
--

CREATE TABLE IF NOT EXISTS `news` (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` text NOT NULL,
  `time` int(11) NOT NULL,
  `subject` text NOT NULL,
  `body` text NOT NULL,
  UNIQUE KEY `id` (`id`),
  KEY `time` (`time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `nicenotices`
--

CREATE TABLE IF NOT EXISTS `nicenotices` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `ip` varchar(61) NOT NULL,
  `created` int(10) UNSIGNED NOT NULL,
  `board` varchar(58) DEFAULT NULL,
  `creator` int(10) NOT NULL,
  `reason` text,
  `seen` tinyint(1) NOT NULL,
  `post` blob,
  PRIMARY KEY (`id`),
  KEY `ipstart` (`ip`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `nntp_references`
--

CREATE TABLE IF NOT EXISTS `nntp_references` (
  `board` varchar(30) NOT NULL,
  `id` int(11) UNSIGNED NOT NULL,
  `message_id` varchar(255) CHARACTER SET ascii NOT NULL,
  `message_id_digest` varchar(40) CHARACTER SET ascii NOT NULL,
  `own` tinyint(1) NOT NULL,
  `headers` text,
  PRIMARY KEY (`message_id_digest`),
  UNIQUE KEY `message_id` (`message_id`),
  UNIQUE KEY `u_board_id` (`board`,`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `noticeboard`
--

CREATE TABLE IF NOT EXISTS `noticeboard` (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `mod` int(11) NOT NULL,
  `time` int(11) NOT NULL,
  `subject` text NOT NULL,
  `body` text NOT NULL,
  UNIQUE KEY `id` (`id`),
  KEY `time` (`time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `pages`
--

CREATE TABLE IF NOT EXISTS `pages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `board` varchar(58) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `content` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `u_pages` (`name`,`board`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `pms`
--

CREATE TABLE IF NOT EXISTS `pms` (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `sender` int(11) NOT NULL,
  `to` int(11) NOT NULL,
  `message` text NOT NULL,
  `time` int(11) NOT NULL,
  `unread` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `to` (`to`,`unread`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `reports`
--

CREATE TABLE IF NOT EXISTS `reports` (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `time` int(11) NOT NULL,
  `ip` varchar(61) CHARACTER SET ascii NOT NULL,
  `board` varchar(58) DEFAULT NULL,
  `post` int(11) NOT NULL,
  `reason` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `robot`
--

CREATE TABLE IF NOT EXISTS `robot` (
  `hash` varchar(40) CHARACTER SET ascii COLLATE ascii_bin NOT NULL COMMENT 'SHA1',
  PRIMARY KEY (`hash`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `search_queries`
--

CREATE TABLE IF NOT EXISTS `search_queries` (
  `ip` varchar(61) NOT NULL,
  `time` int(11) NOT NULL,
  `query` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `shadow_antispam`
--

CREATE TABLE IF NOT EXISTS `shadow_antispam` (
  `board` varchar(58) NOT NULL,
  `thread` int(11) DEFAULT NULL,
  `hash` char(40) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
  `created` int(11) NOT NULL,
  `expires` int(11) DEFAULT NULL,
  `passed` smallint(6) NOT NULL,
  PRIMARY KEY (`hash`),
  KEY `board` (`board`,`thread`),
  KEY `expires` (`expires`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `shadow_cites`
--

CREATE TABLE IF NOT EXISTS `shadow_cites` (
  `board` varchar(58) NOT NULL,
  `post` int(11) NOT NULL,
  `target_board` varchar(58) NOT NULL,
  `target` int(11) NOT NULL,
  KEY `target` (`target_board`,`target`),
  KEY `post` (`board`,`post`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `shadow_deleted`
--

CREATE TABLE IF NOT EXISTS `shadow_deleted` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `board` varchar(58) NOT NULL,
  `post_id` int(10) NOT NULL,
  `del_time` int(11) NOT NULL,
  `files` text CHARACTER SET ascii NOT NULL,
  `cite_ids` text CHARACTER SET armscii8 NOT NULL,
  PRIMARY KEY (`id`),
  KEY `board` (`board`),
  KEY `post_id` (`post_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `shadow_filehashes`
--

CREATE TABLE IF NOT EXISTS `shadow_filehashes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `board` varchar(58) NOT NULL,
  `thread` int(11) NOT NULL,
  `post` int(11) NOT NULL,
  `filehash` text CHARACTER SET ascii NOT NULL,
  PRIMARY KEY (`id`),
  KEY `thread_id` (`thread`),
  KEY `post_id` (`post`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `theme_settings`
--

CREATE TABLE IF NOT EXISTS `theme_settings` (
  `theme` varchar(40) NOT NULL,
  `name` varchar(40) DEFAULT NULL,
  `value` text,
  KEY `theme` (`theme`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `warnings`
--

CREATE TABLE IF NOT EXISTS `warnings` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `ip` varchar(61) NOT NULL,
  `created` int(10) UNSIGNED NOT NULL,
  `board` varchar(58) DEFAULT NULL,
  `creator` int(10) NOT NULL,
  `reason` text,
  `seen` tinyint(1) NOT NULL,
  `post` blob,
  PRIMARY KEY (`id`),
  KEY `ipstart` (`ip`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `votes_archive`
--

CREATE TABLE IF NOT EXISTS `votes_archive` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `board` varchar(58) CHARACTER SET utf8mb4 NOT NULL,
  `thread_id` int(10) NOT NULL,
  `ip` varchar(61) CHARACTER SET ascii NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `ip` (`ip`, `board`, `thread_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `whitelist`
--

CREATE TABLE IF NOT EXISTS `whitelist`  (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `expiration_time` int(11) NOT NULL,
  `ip` varchar(61) CHARACTER SET ascii NOT NULL,
  `cookie` varchar(40) CHARACTER SET ascii NOT NULL,
  PRIMARY KEY `id` (`id`),
  KEY `expiration_time` (`expiration_time`),
  KEY `ip` (`ip`),
  KEY `cookie` (`cookie`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
