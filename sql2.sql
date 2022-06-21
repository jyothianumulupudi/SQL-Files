create database moviedb; -- created database called moviedb
use moviedb; -- I'm using moviedb database as my default one

select * from actors; -- To retrieve all the values from actors table
select * from director; -- To retrieve all the values from director table
select * from genres; -- To retrieve all the values from genres table
select * from movie; -- To retrieve all the values from movie table
select * from movie_cast; -- To retrieve all the values from movie_cast table
select * from movie_direction; -- To retrieve all the values from movie_direction table
select * from movie_genres; -- To retrieve all the values from movie_genres table
select * from rating; -- To retrieve all the values from rating table
select * from reviewer; -- To retrieve all the values from reviewer table

-- 1. Write a SQL query to find the actors who were cast in the movie 'Annie Hall'.
--  Return actor first name, last name and role.

/* Here I'm using inner join to combine the tables those are actors, movie_cast, movie 
based on common ids in those three tables. Then we will get the result set of first name, 
last name and role of the actor in the movie annie hall.*/

SELECT act_fname AS FIRST_NAME,
       act_lname AS LAST_NAME,
       movie_cast.role AS ROLE
FROM   actors
       INNER JOIN movie_cast
               ON actors.act_id = movie_cast.act_id
       INNER JOIN movie
               ON movie_cast.mov_id = movie.mov_id
                  AND movie.mov_title = 'Annie Hall'; 


-- 2. From the following tables, write a SQL query to find the director who directed 
-- a movie that casted a role for 'Eyes Wide Shut'. Return director first name, last name and movie title.

/*Here I'm combining director, movie_direction, movie tables by using inner join
to get director's first name, last name and title of the movie*/

SELECT director.dir_fname AS Director_First_Name,
       director.dir_lname AS Director_Last_Name,
       movie.mov_title AS Movie_Title
FROM   director
       INNER JOIN movie_direction
               ON director.dir_id = movie_direction.dir_id
       INNER JOIN movie
               ON movie.mov_id = movie_direction.mov_id
                  AND mov_title = "eyes wide shut"; 


-- 3. Write a SQL query to find who directed a movie that casted a role as ‘Sean Maguire’. 
-- Return director first name, last name and movie title.

/*Here I'm using inner join to combine director, movie_director, movie, movie_cast tables by using inner join
then we will get the output of director first name, last name, title of the movie based on the role as 'Sean Maguire'*/

SELECT director.dir_fname AS Director_First_Name,
       director.dir_lname AS Director_Last_Name,
       movie.mov_title AS Movie_Title,
       movie_cast.role AS ROLE
FROM   director
       INNER JOIN movie_direction
               ON director.dir_id = movie_direction.dir_id
       INNER JOIN movie
               ON movie.mov_id = movie_direction.mov_id
       INNER JOIN movie_cast
               ON movie_cast.mov_id = movie_direction.mov_id
                  AND role = "sean maguire";


-- 4. Write a SQL query to find the actors who have not acted in any movie between 1990 and 2000 (Begin and end values are included.). 
-- Return actor first name, last name, movie title and release year. 
/*Here I'm using inner join to combine all the tables actors, movie_cast, movie.
And here I'm retrieving the values of the actors who have not acted in any movie
between 1990 and 2000. */

SELECT actors.act_fname AS Actor_First_Name, 
       actors.act_lname AS Actor_Last_Name,
       movie.mov_title AS Movie_Title,
       movie.mov_year AS Release_Year
FROM   actors
       INNER JOIN movie_cast
               ON actors.act_id = movie_cast.act_id
       INNER JOIN movie
               ON movie_cast.mov_id = movie.mov_id
WHERE  movie.mov_year NOT BETWEEN 1990 AND 2000; 

-- 5. Write a SQL query to find the directors with the number of genres of movies. 
-- Group the result set on director first name, last name and generic title. 
-- Sort the result-set in ascending order by director first name and last name.
-- Return director first name, last name and number of genres of movies.

/*Here I'm using inner join to combine the tables to get the required output*/

SELECT director.dir_fname,
       director.dir_lname,
       genres.gen_title,
       Count(genres.gen_title) AS Count
FROM   director
       INNER JOIN movie_direction
               ON director.dir_id = movie_direction.dir_id
       INNER JOIN movie_genres
               ON movie_direction.mov_id = movie_genres.mov_id
       INNER JOIN genres
               ON movie_genres.gen_id = genres.gen_id
GROUP  BY director.dir_fname,
          director.dir_lname,
          genres.gen_title
ORDER  BY director.dir_fname,
          director.dir_lname ASC; 
          
/*Here is the another way of solving the same problem by using natural join*/
          
/*SELECT director.dir_fname,
       director.dir_lname,
       genres.gen_title,
       Count(genres.gen_title) AS "count"
FROM   director
       natural JOIN movie_direction
       natural JOIN movie_genres
       natural JOIN genres
GROUP  BY director.dir_fname,
          director.dir_lname,
          genres.gen_title
ORDER  BY director.dir_fname,
          director.dir_lname; */
          
-- 6. Write a SQL query to find the movies with year and genres. 
-- Return movie title, movie year and generic title.

/*Hre I'm using inner join to combine the tables based on common ids to get the required output.
Here I'm retrieving the values of the movit title, movie release year, generic title*/

SELECT movie.mov_title AS Movie_Title,
       movie.mov_year AS Movie_Release_Year,
       genres.gen_title AS Genres_Title
FROM   movie
       INNER JOIN movie_genres
               ON movie.mov_id = movie_genres.mov_id
       INNER JOIN genres
               ON movie_genres.gen_id = genres.gen_id; 

-- 7. Write a SQL query to find the movies released before 1st January 1989. 
-- Sort the result-set in descending order by date of release. 
-- Return movie title, release year, date of release, duration, and first and last name of the director. 

/*Here I'm using inner join to combine the tables based on commoin ids.
I'm retrieving the values of  movie title, movie release year, movie release date, movie duration,
director's first name, last name*/

SELECT movie.mov_title,
       movie.mov_year,
       movie.mov_dt_rel,
       movie.mov_time,
       director.dir_fname AS Director_First_Name,
       director.dir_lname AS Director_Last_Name
FROM   movie
       INNER JOIN movie_direction
               ON movie.mov_id = movie_direction.mov_id
       INNER JOIN director
               ON movie_direction.dir_id = director.dir_id
WHERE  movie.mov_dt_rel < '1989-01-01'
ORDER  BY movie.mov_dt_rel DESC; 

-- 8. Write a SQL query to compute the average time and count the number of movies for each genre. 
-- Return genre title, average time and the number of movies for each genre.

/*Here I'm counting the number of movies for each genre.For that I'm combining the tables by using inner join
based on common values in those tables.I'm retrieving the values of genre title, average of movie duration, 
number of movies for each genres*/

SELECT DISTINCT genres.gen_title,
                Avg(movie.mov_time),
                Count(movie.mov_title) AS COUNT
FROM   movie
       INNER JOIN movie_genres
               ON movie.mov_id = movie_genres.mov_id
       INNER JOIN genres
               ON movie_genres.gen_id = genres.gen_id
GROUP  BY genres.gen_title
ORDER  BY Avg(movie.mov_title) ASC; 

-- Here is the anothe way of solving the same problem by using natural join

/*select genres.gen_title, avg(movie.mov_time), count(genres.gen_title)
from movie
natural join movie_genres
natural join genres
group by genres.gen_title;*/

-- 9. Write a SQL query to find movies with the lowest duration. 
-- Return movie title, movie year, director first name, last name, actor first name, last name and role.

/*Here I'm retrieving the values of the movie title, movie release year, director's first name,
last name, actor's first name, last name and the rol as well.*/

SELECT movie.mov_title,
       movie.mov_year,
       director.dir_fname,
       director.dir_lname,
       movie.mov_time,
       actors.act_fname,
       actors.act_lname,
       movie_cast.role
FROM   movie
       INNER JOIN movie_direction
               ON movie.mov_id = movie_direction.mov_id
       INNER JOIN director
               ON movie_direction.dir_id = director.dir_id
       INNER JOIN movie_cast
               ON movie_direction.mov_id = movie_cast.mov_id
       INNER JOIN actors
               ON movie_cast.act_id = actors.act_id
WHERE  mov_time = (SELECT Min(mov_time)
                   FROM   movie); 

-- Here is the another solution by using natural join                   

/*SELECT mov_title, mov_year, mov_time, dir_fname, dir_lname, 
       act_fname, act_lname, role 
FROM  movie
NATURAL JOIN movie_direction
NATURAL JOIN movie_cast
NATURAL JOIN director
NATURAL JOIN actors
WHERE mov_time=(SELECT MIN(mov_time) FROM movie);*/
