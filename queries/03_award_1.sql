SELECT wineries.name AS winery, 
		vintages.name AS vintage, 
		vintages.year
FROM wineries
JOIN wines
	ON wines.winery_id = wineries.id
JOIN vintages
	ON vintages.wine_id = wines.id
WHERE vintages.year IS NOT NULL AND vintages.year > 0
ORDER BY vintages.year 
LIMIT 1;

