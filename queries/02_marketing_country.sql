SELECT countries.name, countries.users_count,
	COUNT(wines.name) AS total_wines_country, 
	ROUND(AVG(wines.ratings_average), 2) AS average_total_ratings
FROM countries
JOIN regions
	ON regions.country_code = countries.code
JOIN wines
	ON wines.region_id = regions.id
GROUP BY countries.name
/* FILTER LOGIC: Identifying the "High-Quality Underdog"
  - total_wines_country > 50: The 'Shield'. Ensures a large enough sample size for consistency.
  - average_total_ratings >= 4.0: The 'Signal'. Targets elite-tier wine production.
*/
HAVING total_wines_country > 50 AND average_total_ratings >= 4.4
/* SORT LOGIC: Finding Low Saturation
  - Primary target: Countries with the lowest user count to maximize growth potential.
*/
ORDER BY countries.users_count 
