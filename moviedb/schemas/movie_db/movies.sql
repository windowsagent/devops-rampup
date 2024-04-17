CREATE TABLE `movies` (
  `title` varchar(250) NOT NULL,
  `release_year` varchar(250) DEFAULT NULL,
  `score` int DEFAULT NULL,
  `reviewer` varchar(250) DEFAULT NULL,
  `publication` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`title`),
  KEY `reviewer` (`reviewer`),
  CONSTRAINT `movies_ibfk_1` FOREIGN KEY (`reviewer`) REFERENCES `reviewers` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
