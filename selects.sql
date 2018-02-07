//GET ALL ENNDED OFFERS

SELECT
	`end` AS `billdate`,
  TIMESTAMPDIFF(Minute, `start`, `end`) AS `minutes`,
  ROUND(`car_offer`.`price_hourly`/60, 2)AS `costs_per_minute`,
  ROUND((SELECT `minutes`)*`car_offer`.`price_hourly`/60, 2)AS `time_price`,
	(SELECT SUM(`extra_fee`.`price`) FROM `extra_fee` WHERE `order`.`order_id` = `order_has_extra_fee`.`order_id`) AS `extra_fees`,
	ROUND((SELECT `time_price`)+(SELECT `extra_fees`), 2) AS `full_price`,
	(SELECT SUM(`payment`.`value`) FROM `payment` WHERE `order`.`order_id` = `payment`.`order_id`) AS `recently_paid`,
  ROUND((SELECT `time_price`)+(SELECT `extra_fees`)-(SELECT `recently_paid`), 2) AS `diiference_to_pay`
FROM `order`
LEFT JOIN `car_offer` ON `order`.`car_offer_id` = `car_offer`.`car_offer_id`
LEFT JOIN `order_has_extra_fee` ON `order`.`order_id` = `order_has_extra_fee`.`order_id`
LEFT JOIN `extra_fee` ON `order_has_extra_fee`.`extra_fee_id` = `extra_fee`.`extra_fee_id`
LEFT JOIN `payment` ON `order`.`order_id` = `payment`.`order_id`
WHERE
	`end` IS NOT NULL
GROUP BY
	`order`.`order_id`


//GET ALL OPEN OFFERS
SELECT
	NOW() AS `billdate`,
  TIMESTAMPDIFF(Minute, `start`, NOW()) AS `minutes`,
  ROUND( `car_offer`.`price_hourly`/60, 2)AS `costs_per_minute`,
  ROUND((SELECT `minutes`)*`car_offer`.`price_hourly`/60, 2)AS `time_price`,
	(SELECT SUM(`payment`.`value`) FROM `payment` WHERE `order`.`order_id` = `payment`.`payment_id`) AS `recently_paid`,
  ROUND((SELECT `time_price`)-(SELECT `recently_paid`), 2) AS `actuel_price`
FROM `order`
LEFT JOIN `car_offer` ON `order`.`car_offer_id` = `car_offer`.`car_offer_id`
LEFT JOIN `payment` ON `order`.`order_id` = `payment`.`order_id`
WHERE
	`end` IS  NULL
GROUP BY
	`order`.`order_id`
