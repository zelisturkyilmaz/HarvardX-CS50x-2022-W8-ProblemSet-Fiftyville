-- Keep a log of any SQL queries you execute as you solve the mystery.
SELECT description FROM crime_scene_reports WHERE day = "28" AND month = "7" AND year = "2021" AND street = "Humphrey Street";

--Theft of the CS50 duck took place at 10:15am at the Humphrey Street bakery. Interviews were conducted today with three witnesses who were present at the time – each of their interview transcripts mentions the bakery.

--10:15am at the Humphrey Street bakery
--each of their interview transcripts mentions the bakery.

SELECT name, transcript FROM interviews WHERE year = 2021 AND month = 7 AND day = 28 AND transcript LIKE '%bakery%';

--Ruth	Sometime within ten minutes of the theft, I saw the thief get into a car in the bakery parking lot and drive away. If you have security footage from the bakery parking lot, you might want to look for cars that left the parking lot in that time frame.

SELECT name FROM people JOIN bakery_security_logs ON people.license_plate = bakery_security_logs.license_plate WHERE day = "28" AND month = "7" AND year = "2021" AND hour = "10" AND minute >= "15" AND minute < "25" AND activity = "exit";

--Vanessa, Bruce, Barry, Luca, Sofia, Iman, Diana, Kelsey


--Eugene	I don't know the thief's name, but it was someone I recognized. Earlier this morning, before I arrived at Emma's bakery, I was walking by the ATM on Leggett Street and saw the thief there withdrawing some money.

SELECT DISTINCT name FROM people JOIN bank_accounts ON people.id = bank_accounts.person_id JOIN atm_transactions ON bank_accounts.account_number = atm_transactions.account_number WHERE day = "28" AND month = "7" AND year = "2021" AND transaction_type = "withdraw" AND atm_location = "Leggett Street";

--Luca, Kenny, Taylor, Bruce, Brooke, Iman, Benista, Diana

--Raymond	As the thief was leaving the bakery, they called someone who talked to them for less than a minute. In the call, I heard the thief say that they were planning to take the earliest flight out of Fiftyville tomorrow. The thief then asked the person on the other end of the phone to purchase the flight

SELECT name FROM people JOIN passengers ON people.passport_number = passengers.passport_number WHERE flight_id = (SELECT id FROM flights WHERE day = "29" AND month = "7" AND year = "2021" ORDER BY hour,minute LIMIT 1);

--Doris, Sofia, Bruce, Edward, Kelsey, Taylor, Kenny, Luca

SELECT city FROM airports WHERE id = (SELECT destination_airport_id FROM flights WHERE day = "29" AND month = "7" AND year = "2021" ORDER BY hour,minute LIMIT 1);

--New York City --flight

SELECT name FROM people JOIN phone_calls ON people.phone_number = phone_calls.caller WHERE day = "28" AND month = "7" AND year = "2021" AND duration < "60";

--Sofia, Kelsey, Bruce, Kelsey, Taylor, Diana, Carina, Kenny, Benista

SELECT name FROM people JOIN passengers ON people.passport_number = passengers.passport_number WHERE flight_id = (SELECT id FROM flights WHERE day = "29" AND month = "7" AND year = "2021" ORDER By hour, minute LIMIT 1) INTERSECT SELECT DISTINCT name FROM people JOIN bank_accounts ON people.id = bank_accounts.person_id JOIN atm_transactions ON bank_accounts.account_number = atm_transactions.account_number WHERE day = "28" AND month = "7" AND year = "2021" AND transaction_type = "withdraw" AND atm_location = "Leggett Street" INTERSECT SELECT name FROM people JOIN phone_calls ON people.phone_number = phone_calls.caller WHERE day = "28" AND month = "7" AND year = "2021" AND duration < "60" INTERSECT SELECT name FROM people JOIN bakery_security_logs ON people.license_plate = bakery_security_logs.license_plate WHERE day = "28" AND month = "7" AND year = "2021" AND hour = "10" AND minute >= "15" AND minute < "25" AND activity = "exit";

--Bruce - Thief

SELECT name FROM people JOIN phone_calls ON people.phone_number = phone_calls.receiver WHERE day = "28" AND month = "7" AND year = "2021" AND duration < "60" AND caller = (SELECT phone_number FROM people WHERE name = "Bruce");

--Robin - accomplice