SELECT
	sumdid,
	pubdatetime::date,
	chargelevel
FROM scooters
WHERE chargelevel > 0
ORDER BY chargelevel ASC