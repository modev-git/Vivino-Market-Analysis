SELECT wineries.name AS winery_name, 
	AVG(wines.ratings_average) AS wines_average, 
	COUNT(wines.id) as num_wines
FROM wineries
JOIN wines	
	ON wines.winery_id = wineries.id
GROUP BY winery_name
HAVING num_wines < 5
ORDER BY wines_average DESC
LIMIT 1;
