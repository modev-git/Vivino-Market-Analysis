SELECT countries.name AS country, 
	ROUND(AVG(wines.ratings_average), 2) AS avg_wine_rating

FROM countries

JOIN regions
	ON regions.country_code = countries.code
JOIN wines
	ON wines.region_id = regions.id
	
GROUP BY countries.name
ORDER BY ROUND(AVG(wines.ratings_average), 2) DESC


	