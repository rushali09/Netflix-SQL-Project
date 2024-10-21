CREATE TABLE NETFLIX (

SHOW_ID VARCHAR(6),
TYPE VARCHAR(10),
TITLE VARCHAR(150),
DIRECTOR VARCHAR(208),
CASTS VARCHAR(1000),
COUNTRY VARCHAR(150),
DATE_ADDED VARCHAR(50),
RELEASE_YEAR INT,
RATING VARCHAR(10),
DURATION VARCHAR(15),
LISTED_IN VARCHAR(100),
DESCRIPTION VARCHAR(250)

);

SELECT * FROM NETFLIX;

SELECT COUNT(*) AS TOTAL_DATA FROM NETFLIX;


-- 15 BUSINESS PROBLEMS 

-- 1.	Count the number of Movies vs TV Shows.

SELECT TYPE, COUNT(*) AS TOTAL_DATA
FROM NETFLIX 
GROUP BY TYPE;

-- 2.	Find the most common rating for movies and TV shows. or what is the max rating given to movies/ TV shows
-- GROUP BY 1, 2- group by column 1 and column 2
-- ORDER BY 1, 3 DESC- order by column 1 and for column 3 order it in descending order

SELECT TYPE, RATING
FROM 
	(SELECT 
		TYPE, 
		RATING, 
		COUNT(*),
		RANK() OVER (PARTITION BY TYPE ORDER BY COUNT(*) DESC) AS RANKING
	FROM NETFLIX
	GROUP BY 1,2
	ORDER BY 1, 3 DESC
	) AS T1
WHERE RANKING = 1;



3.	List all movies released in a specific year (e.g., 2000) 

-- MOVIE
-- YEAR 2020

SELECT * 
FROM NETFLIX
WHERE type = 'Movie' AND release_year= 2000;

4.	Find the top 5 countries with the most content on Netflix

-- top 5 countries
-- max content 



-- SELECT COUNTRY FROM NETFLIX, it has multiple country names in same row

-- STRING TO ARRAY- Converts multiple values in same line as an individual value in array format 
-- UNNEST: seperated each value in array per row

SELECT UNNEST(STRING_TO_ARRAY(COUNTRY, ',')) AS NEW_COUNTRY, COUNT(SHOW_ID) AS TOTAL_CONTENT
FROM NETFLIX
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;


SELECT 
	UNNEST(STRING_TO_ARRAY(COUNTRY, ',')) AS NEW_COUNTRY
FROM NETFLIX

-- 5. Identify the longest movie or TV show duration
--duration
-- movie/ tv show 

SELECT * 
FROM NETFLIX
WHERE TYPE= 'Movie' AND DURATION = (SELECT MAX(DURATION) FROM NETFLIX)


6. Find content added in the last 5 years

-- SHOW ID IN LAST 5 YEARS
-- SHOW ID 
-- 
SELECT *
FROM NETFLIX
WHERE 	TO_DATE(date_added, 'DD Mon YY') >= CURRENT_DATE - INTERVAL '5 YEARS';

SELECT CURRENT_DATE - INTERVAL '5 YEARS';


-- 7. Find all the movies/TV shows by director 'Steven Spielberg’!

SELECT TYPE, TITLE
FROM NETFLIX
WHERE DIRECTOR ILIKE  '%Steven Spielberg%';

-- 8. List all TV shows with more than 5 seasons

-- TV SHOWS
-- SEASONS>5


SELECT 
	*
FROM NETFLIX
WHERE TYPE= 'TV Show'
AND SPLIT_PART(duration, ' ' , 1) :: numeric
 >= 5 

-- 9. Count the number of content items in each genre


SELECT * FROM NETFLIX;


SELECT 

	UNNEST(STRING_TO_ARRAY(listed_in, ',')) as genre,
	COUNT(show_id)

FROM NETFLIX
GROUP BY genre;


-- 10.	Find each year and average num of content released by India on Netflix. return top5 year with highest avg content release

SELECT
EXTRACT (YEAR FROM TO_DATE(date_added, 'DD Mon YY')) as year,
COUNT(*),
COUNT(*):: numeric/(SELECT COUNT(*) FROM netflix WHERE country = 'India')::numeric * 100 as avg_content_per
FROM netflix
WHERE country = 'India'
GROUP BY 1



-- 11.	List all movies that are documentaries

SELECT * FROM netflix
WHERE
listed_in ILIKE '% documentaries%'


























