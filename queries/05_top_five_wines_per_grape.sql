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

/*
1. The Temporary Container (CTE) 📦
WITH ranked_wines AS ( ... )
This tells the database to run the massive query inside the parentheses first and store the results in a temporary, invisible box named ranked_wines. We do this so we can easily filter the results later.

2. The Ranking Engine ⚙️
SELECT grapes.name..., wines.name..., wines.ratings_average,
Here, we grab the basic text and number columns.
ROW_NUMBER() OVER(PARTITION BY grapes.name ORDER BY wines.ratings_average DESC) as rank
This generates our top 5 list dynamically:

ROW_NUMBER(): Creates a brand-new column of counting numbers (1, 2, 3...).

PARTITION BY grapes.name: Builds a virtual wall between each grape type.

ORDER BY ... DESC: Sorts the wines inside those walls by their rating, from highest to lowest.

Result: It counts 1, 2, 3... for Cabernet, hits the partition wall for Chardonnay, and restarts the count at 1.

3. The Data Bridge & Filter 🌉
FROM wines JOIN ...
WHERE grapes.name IN ('Cabernet Sauvignon', 'Merlot', 'Chardonnay')
The JOIN commands link the tables together like a chain to trace a specific wine to its region, then to its country, and finally to that country's most used grapes. The WHERE clause drops millions of rows instantly, only allowing our Top 3 grapes to enter the ranking engine.

4. The Final Output 🎯
SELECT grape_name, wine_name, ratings_average FROM ranked_wines WHERE rank <= 5;
We open our temporary ranked_wines box, select the columns, and apply one final rule: only print the row if our mathematically generated rank is 5 or less.
