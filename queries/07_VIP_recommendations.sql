SELECT wines.name AS wine,
	wines.ratings_average,
	wines.ratings_count

FROM wines
JOIN regions
	ON regions.id = wines.region_id
JOIN countries
	ON countries.code = regions.country_code
JOIN most_used_grapes_per_country
	ON most_used_grapes_per_country.country_code = countries.code
JOIN grapes
	ON grapes.id = most_used_grapes_per_country.grape_id
	
WHERE grapes.name = 'Cabernet Sauvignon'
	AND wines.ratings_average > 4.5
	AND wines.ratings_count > 20000
	
ORDER BY wines.ratings_average DESC
	
LIMIT 5;