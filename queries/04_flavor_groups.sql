SELECT wines.name AS wine_name, 
	keywords.name AS flavor_name, 
	SUM(keywords_wine.count) AS user_flavor_count,
	keywords_wine.group_name AS flavor_group
FROM wines
JOIN keywords_wine
	ON keywords_wine.wine_id = wines.id
JOIN keywords
	ON keywords.id = keywords_wine.keyword_id
WHERE keywords.name IN ('coffee', 'toast', 'green apple', 'cream', 'citrus')
GROUP BY wines.name, keywords.name, keywords_wine.group_name
HAVING SUM(keywords_wine.count) > 10


