CREATE TABLE `reviewers` (
  `name` varchar(255) NOT NULL,
  `avatar` varchar(250) DEFAULT NULL,
  `publication` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `publication` (`publication`),
  CONSTRAINT `reviewers_ibfk_1` FOREIGN KEY (`publication`) REFERENCES `publications` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
