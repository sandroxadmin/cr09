-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Erstellungszeit: 07. Feb 2018 um 09:53
-- Server-Version: 10.1.30-MariaDB
-- PHP-Version: 7.2.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Datenbank: `cr09_christian_hofer_carrental`
--

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `car`
--

CREATE TABLE `car` (
  `car_id` int(11) NOT NULL,
  `model` varchar(45) DEFAULT NULL,
  `location_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Daten für Tabelle `car`
--

INSERT INTO `car` (`car_id`, `model`, `location_id`) VALUES
(1, 'Tesla', 1),
(2, 'Tesla', 1);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `car_offer`
--

CREATE TABLE `car_offer` (
  `car_offer_id` int(11) NOT NULL,
  `car_id` int(11) NOT NULL,
  `price_hourly` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Daten für Tabelle `car_offer`
--

INSERT INTO `car_offer` (`car_offer_id`, `car_id`, `price_hourly`) VALUES
(1, 1, 2.2),
(2, 2, 2.2);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `customer`
--

CREATE TABLE `customer` (
  `customer_id` int(11) NOT NULL,
  `name` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Daten für Tabelle `customer`
--

INSERT INTO `customer` (`customer_id`, `name`) VALUES
(1, 'Christian Hofer'),
(2, 'John Doe');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `extra_fee`
--

CREATE TABLE `extra_fee` (
  `extra_fee_id` int(11) NOT NULL,
  `name` varchar(45) NOT NULL,
  `price` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Daten für Tabelle `extra_fee`
--

INSERT INTO `extra_fee` (`extra_fee_id`, `name`, `price`) VALUES
(1, 'Clean Up', 29.9),
(2, 'repair min', 49.9);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `location`
--

CREATE TABLE `location` (
  `location_id` int(11) NOT NULL,
  `name` varchar(45) DEFAULT NULL,
  `address` varchar(45) DEFAULT NULL,
  `pick_up` tinyint(4) DEFAULT NULL,
  `return` tinyint(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Daten für Tabelle `location`
--

INSERT INTO `location` (`location_id`, `name`, `address`, `pick_up`, `return`) VALUES
(1, 'Down Town', 'Down Town 1', 1, 1),
(2, 'Upper Town', 'Upper Town 1', 0, 1);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `order`
--

CREATE TABLE `order` (
  `order_id` int(11) NOT NULL,
  `car_offer_id` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `location_id` int(11) NOT NULL,
  `start` datetime NOT NULL,
  `end` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Daten für Tabelle `order`
--

INSERT INTO `order` (`order_id`, `car_offer_id`, `customer_id`, `location_id`, `start`, `end`) VALUES
(1, 1, 1, 1, '2018-02-05 00:00:00', '2018-02-05 06:00:00'),
(2, 2, 2, 1, '2018-02-05 00:00:00', NULL),
(3, 1, 1, 1, '2018-02-05 06:00:00', '2018-02-05 08:00:00');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `order_has_extra_fee`
--

CREATE TABLE `order_has_extra_fee` (
  `order_id` int(11) NOT NULL,
  `extra_fee_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Daten für Tabelle `order_has_extra_fee`
--

INSERT INTO `order_has_extra_fee` (`order_id`, `extra_fee_id`) VALUES
(1, 1),
(1, 2),
(2, 2);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `payment`
--

CREATE TABLE `payment` (
  `payment_id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `value` double NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Daten für Tabelle `payment`
--

INSERT INTO `payment` (`payment_id`, `order_id`, `value`, `timestamp`) VALUES
(1, 1, 40, '2018-02-04 23:00:00'),
(2, 2, 20, '2018-02-04 23:00:00'),
(3, 1, 5, '2018-02-04 23:00:00');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `reservation`
--

CREATE TABLE `reservation` (
  `reservation_id` int(11) NOT NULL,
  `car_id` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `location_id` int(11) NOT NULL,
  `datetime` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Daten für Tabelle `reservation`
--

INSERT INTO `reservation` (`reservation_id`, `car_id`, `customer_id`, `location_id`, `datetime`) VALUES
(1, 1, 1, 1, '2018-02-01 04:00:00');

--
-- Indizes der exportierten Tabellen
--

--
-- Indizes für die Tabelle `car`
--
ALTER TABLE `car`
  ADD PRIMARY KEY (`car_id`),
  ADD KEY `fk_car_location_idx` (`location_id`);

--
-- Indizes für die Tabelle `car_offer`
--
ALTER TABLE `car_offer`
  ADD PRIMARY KEY (`car_offer_id`),
  ADD KEY `fk_car_offer_car_idx` (`car_id`);

--
-- Indizes für die Tabelle `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`customer_id`);

--
-- Indizes für die Tabelle `extra_fee`
--
ALTER TABLE `extra_fee`
  ADD PRIMARY KEY (`extra_fee_id`);

--
-- Indizes für die Tabelle `location`
--
ALTER TABLE `location`
  ADD PRIMARY KEY (`location_id`);

--
-- Indizes für die Tabelle `order`
--
ALTER TABLE `order`
  ADD PRIMARY KEY (`order_id`),
  ADD KEY `fk_order_car_offer_idx` (`car_offer_id`),
  ADD KEY `fk_order_customer_idx` (`customer_id`),
  ADD KEY `fk_order_location_idx` (`location_id`);

--
-- Indizes für die Tabelle `order_has_extra_fee`
--
ALTER TABLE `order_has_extra_fee`
  ADD PRIMARY KEY (`order_id`,`extra_fee_id`),
  ADD KEY `fk_order_has_extra_fee_extra_fee1_idx` (`extra_fee_id`),
  ADD KEY `fk_order_has_extra_fee_order1_idx` (`order_id`);

--
-- Indizes für die Tabelle `payment`
--
ALTER TABLE `payment`
  ADD PRIMARY KEY (`payment_id`),
  ADD KEY `fk_payment_order_idx` (`order_id`);

--
-- Indizes für die Tabelle `reservation`
--
ALTER TABLE `reservation`
  ADD PRIMARY KEY (`reservation_id`),
  ADD KEY `fk_reservation_car_idx` (`car_id`),
  ADD KEY `fk_reservation_customer_idx` (`customer_id`),
  ADD KEY `fk_reservation_location_idx` (`location_id`);

--
-- AUTO_INCREMENT für exportierte Tabellen
--

--
-- AUTO_INCREMENT für Tabelle `car`
--
ALTER TABLE `car`
  MODIFY `car_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT für Tabelle `car_offer`
--
ALTER TABLE `car_offer`
  MODIFY `car_offer_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT für Tabelle `customer`
--
ALTER TABLE `customer`
  MODIFY `customer_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT für Tabelle `extra_fee`
--
ALTER TABLE `extra_fee`
  MODIFY `extra_fee_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT für Tabelle `location`
--
ALTER TABLE `location`
  MODIFY `location_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT für Tabelle `order`
--
ALTER TABLE `order`
  MODIFY `order_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT für Tabelle `payment`
--
ALTER TABLE `payment`
  MODIFY `payment_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT für Tabelle `reservation`
--
ALTER TABLE `reservation`
  MODIFY `reservation_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints der exportierten Tabellen
--

--
-- Constraints der Tabelle `car`
--
ALTER TABLE `car`
  ADD CONSTRAINT `fk_car_location` FOREIGN KEY (`location_id`) REFERENCES `location` (`location_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints der Tabelle `car_offer`
--
ALTER TABLE `car_offer`
  ADD CONSTRAINT `fk_car_offer_car` FOREIGN KEY (`car_id`) REFERENCES `car` (`car_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints der Tabelle `order`
--
ALTER TABLE `order`
  ADD CONSTRAINT `fk_order_car_offer` FOREIGN KEY (`car_offer_id`) REFERENCES `car_offer` (`car_offer_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_order_customer` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_order_location` FOREIGN KEY (`location_id`) REFERENCES `location` (`location_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints der Tabelle `order_has_extra_fee`
--
ALTER TABLE `order_has_extra_fee`
  ADD CONSTRAINT `fk_order_has_extra_fee_extra_fee1` FOREIGN KEY (`extra_fee_id`) REFERENCES `extra_fee` (`extra_fee_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_order_has_extra_fee_order1` FOREIGN KEY (`order_id`) REFERENCES `order` (`order_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints der Tabelle `payment`
--
ALTER TABLE `payment`
  ADD CONSTRAINT `fk_payment_order1` FOREIGN KEY (`order_id`) REFERENCES `order` (`order_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints der Tabelle `reservation`
--
ALTER TABLE `reservation`
  ADD CONSTRAINT `fk_reservation_car1` FOREIGN KEY (`car_id`) REFERENCES `car_offer` (`car_offer_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_reservation_customer1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_reservation_location1` FOREIGN KEY (`location_id`) REFERENCES `location` (`location_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
