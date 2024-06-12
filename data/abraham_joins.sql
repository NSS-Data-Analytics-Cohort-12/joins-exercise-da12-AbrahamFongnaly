
-- ** Movie Database project. See the file movies_erd for table\column info. **

-- 1. Give the name, release year, and worldwide gross of the lowest grossing movie.
-- SELECT specs.film_title, specs.release_year, MIN(revenue.worldwide_gross) 
-- FROM specs
-- LEFT JOIN revenue
-- ON specs.movie_id = revenue.movie_id
-- GROUP BY specs.film_title, specs.release_year
-- ORDER BY MIN(revenue.worldwide_gross);
--Semi-Tough

-- 2. What year has the highest average imdb rating?
-- SELECT DISTINCT(release_year), AVG(imdb_rating) AS avg_rating
-- FROM specs
-- INNER JOIN rating
-- 	USING (movie_id)
-- 	GROUP BY release_year
-- 	ORDER BY avg_rating DESC;
-- 1991

-- 3. What is the highest grossing G-rated movie? Which company distributed it?
-- SELECT mpaa_rating, domestic_distributor_id,worldwide_gross, film_title, company_name
-- FROM specs
-- INNER JOIN revenue
-- USING (movie_id)
-- INNER JOIN distributors
-- ON domestic_distributor_id=distributor_id
-- 	WHERE mpaa_rating='G'
-- 	ORDER BY worldwide_gross DESC;
--Toy Story 4; Walt Disney

-- 4. Write a query that returns, for each distributor in the distributors table, the distributor name and the number of movies associated with that distributor in the movies 
-- table. Your result set should include all of the distributors, whether or not they have any movies in the movies table.
-- SELECT company_name, COUNT(film_title)
-- FROM distributors
-- LEFT JOIN specs
-- ON domestic_distributor_id=distributor_id
-- GROUP BY company_name
-- ORDER BY COUNT(film_title) DESC;

-- 5. Write a query that returns the five distributors with the highest average movie budget.
-- SELECT company_name, AVG(revenue.film_budget):: MONEY
-- FROM distributors
-- JOIN specs
-- ON distributors.distributor_id = specs.domestic_distributor_id
-- JOIN revenue
-- ON revenue.movie_id=specs.movie_id
-- GROUP BY distributors.company_name
-- 	ORDER BY AVG(revenue.film_budget) DESC
-- LIMIT 5;

-- 6. How many movies in the dataset are distributed by a company which is not headquartered in California? Which of these movies has the highest imdb rating?
-- SELECT COUNT(specs.*), specs.film_title, distributors.company_name, distributors.headquarters, rating.imdb_rating
-- FROM distributors
-- JOIN specs
-- ON distributors.distributor_id = specs.domestic_distributor_id
-- JOIN rating
-- USING (movie_id)
-- WHERE distributors.headquarters NOT LIKE '%CA%'
-- GROUP BY distributors.company_name, rating.imdb_rating, distributors.headquarters,specs.film_title
-- ORDER BY COUNT(specs.film_title) DESC;
--2, Dirty Dancing


-- 7. Which have a higher average rating, movies which are over two hours long or movies which are under two hours?
-- SELECT '2 Hrs or More' AS movie_length, AVG(rating.imdb_rating) AS avg_rating
-- FROM rating
-- JOIN specs
-- USING (movie_id)
-- WHERE specs.length_in_min >= 120
-- UNION
-- SELECT '2 Hrs or Less' AS movie_length, AVG(rating.imdb_rating) AS avg_rating
-- FROM rating
-- JOIN specs
-- USING (movie_id)
-- WHERE specs.length_in_min <= 120;
