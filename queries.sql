--- #4 pull a clean trips file

SELECT *
FROM trips
WHERE tripduration > 1 AND tripduration < (60*24)


------------------------------------------------
WITH s AS
	(SELECT
		DISTINCT(pubdatetime::date) as date,
	 	companyname AS company,
		sumdid,
		MIN(chargelevel)
	FROM scooters
	WHERE chargelevel > 0
	GROUP BY date, company, sumdid),

t AS
	(SELECT
		DISTINCT(pubtimestamp::date) as date,
		companyname AS company,
		triprecordnum as trip_id,
		sumdid
	FROM trips
	WHERE tripduration > 1 AND tripduration < (60*24))
	
SELECT
	s.date,
	s.company,
	s.sumdid,
	trip_id
FROM s
LEFT JOIN t
USING (sumdid, date)

		
SELECT DISTINCT(companyname) AS company_name,
	startdate AS start_date,
	EXTRACT(HOUR from starttime) AS hour,
	COUNT(DISTINCT triprecordnum) AS scooters_needed
FROM trips
GROUP BY company_name, start_date, hour
LIMIT 5;