WITH ranked_wines AS (
	SELECT grapes.name AS grape_name, 
        wines.name AS wine_name,
        wines.ratings_average,
		ROW_NUMBER() OVER(PARTITION BY grapes.name ORDER BY wines.ratings_average DESC) as rank
	
	FROM wines
	JOIN regions
		ON regions.id = wines.region_id
	JOIN countries
		ON countries.code = regions.country_code
	JOIN most_used_grapes_per_country
		ON most_used_grapes_per_country.country_code = countries.code
	JOIN grapes
		ON grapes.id = most_used_grapes_per_country.grape_id
	
	WHERE grapes.name IN ('Cabernet Sauvignon', 'Merlot', 'Chardonnay')
)

SELECT grape_name, wine_name, ratings_average
FROM ranked_wines
WHERE rank <= 5;


