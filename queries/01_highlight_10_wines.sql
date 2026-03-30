SELECT name, ratings_average, ratings_count

FROM wines

-- WHERE Logic: 
--        10k+ is ~50% above the 6.4k ratings_avg (high-reliability wines); 
--       <50k to exclude over-saturated mega-brands 

WHERE ratings_count BETWEEN 10000 AND 50000

ORDER BY ratings_average DESC, ratings_count DESC

LIMIT 10;