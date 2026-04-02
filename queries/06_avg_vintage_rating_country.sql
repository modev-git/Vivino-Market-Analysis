SELECT countries.name AS country,
		ROUND(AVG(vintages.ratings_average), 2) AS avg_vintage_rating

FROM vintages
JOIN wines
	ON wines.id = vintages.wine_id
JOIN regions
	ON regions.id = wines.region_id
JOIN countries
	ON countries.code = regions.country_code

-- Enforce sample size minimum to prevent unrated/new releases (0.0) 
-- from corrupting the mathematical mean.
WHERE vintages.ratings_count > 50
GROUP BY countries.name
ORDER BY ROUND(AVG(vintages.ratings_average), 2) DESC