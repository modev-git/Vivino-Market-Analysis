SELECT wineries.name, 
	COUNT(wines.id) AS num_wines, 
	ROUND(AVG(wines.ratings_average), 2) AS average_ratings
FROM wineries
JOIN wines	
	ON wines.winery_id = wineries.id
GROUP BY wineries.name
HAVING average_ratings > 4.0
ORDER BY num_wines
LIMIT 1;