SELECT grapes.name AS grape_name,
	SUM(most_used_grapes_per_country.wines_count) AS wines_using_grape
FROM most_used_grapes_per_country
JOIN grapes
	ON grapes.id = most_used_grapes_per_country.grape_id
GROUP BY grapes.name
ORDER BY SUM(most_used_grapes_per_country.wines_count) DESC
LIMIT 3 
