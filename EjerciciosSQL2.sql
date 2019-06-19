/*PRACTICA 1*/
/*Ejercicio 1*/
SELECT g.name, m.title
FROM genres AS g
INNER JOIN movies AS m ON m.genre_id = g.id
ORDER BY g.name DESC;

/*Ejercicio 2*/
SELECT m.title, g.name, a.first_name, a.last_name
FROM movies as m
INNER JOIN actor_movie AS am ON am.movie_id = m.id
INNER JOIN actors AS a ON am.actor_id = a.id
INNER JOIN genres AS g ON g.id = m.genre_id;

/*Ejercicio 3*/
SELECT a.first_name, m.title
FROM movies as m
INNER JOIN actor_movie AS am ON am.movie_id = m.id
INNER JOIN actors AS a ON am.actor_id = a.id
ORDER BY a.first_name;

/*Ejercicio 4*/
SELECT CONCAT(m.title, ' - ', g.name) as titulo_genero
FROM movies AS m
INNER JOIN genres AS g ON g.id = m.genre_id
ORDER BY g.name, m.title;

/*Ejercicio 5*/
SELECT DISTINCT e.title, seasons.number, series.title, g.name, COUNT(a.id)
FROM episodes AS e
INNER JOIN seasons ON e.season_id = seasons.id
INNER JOIN series ON seasons.serie_id = series.id
INNER JOIN genres AS g ON g.id = series.genre_id
INNER JOIN actor_episode AS ae ON e.id = ae.episode_id
INNER JOIN actors AS a ON a.id = ae.actor_id
GROUP BY e.id;

/*Ejercicio 6*/
SELECT g.name, AVG(m.rating) as promedio_rating
FROM genres AS g
INNER JOIN movies AS m ON m.genre_id = g.id
WHERE m.rating > 5
GROUP BY g.name;

/*Ejercicio 7*/
SELECT series.title, COUNT(e.id) AS cant_ep_2016
FROM series
INNER JOIN seasons ON seasons.serie_id = series.id
INNER JOIN episodes AS e ON e.season_id = seasons.id
WHERE YEAR(e.release_date) = 2016
GROUP BY e.season_id;

/*Ejercicio 8*/
SELECT series.title, COUNT(e.id) AS cant_ep_año_actual
FROM series
INNER JOIN seasons ON seasons.serie_id = series.id
INNER JOIN episodes AS e ON e.season_id = seasons.id
WHERE  YEAR(e.release_date) = YEAR(NOW())
GROUP BY e.season_id;


/*PRACTICA 2*/
/*Ejercicio 1*/
SELECT CONCAT(first_name, " ", last_name) AS name
FROM actors 
WHERE favorite_movie_id IN
	(SELECT id
    FROM movies
    WHERE title LIKE "%t%");
    
/*Ejercicio 2*/
SELECT CONCAT(a.first_name, " ", a.last_name) AS name, m.title
FROM actors AS a
INNER JOIN actor_movie AS am ON am.actor_id = a.id
INNER JOIN movies AS m ON am.movie_id = m.id
WHERE a.favorite_movie_id IN
	(SELECT id
    FROM movies
    WHERE title LIKE "%t%");

/*Ejercicio 3*/
SELECT g.name
FROM genres AS g
INNER JOIN series AS s ON s.genre_id = g.id
WHERE s.id IN
	(SELECT id
    FROM series
    WHERE YEAR(release_date) >= 2013);

/*Ejercicio 4*/
SELECT DISTINCT m.title
FROM movies AS m
INNER JOIN actors AS a ON a.favorite_movie_id = m.id
WHERE m.id NOT IN
	(SELECT DISTINCT favorite_movie_id
    FROM actors
    WHERE favorite_movie_id IS NOT NULL);

/*Ejercicio 5*/
SELECT DISTINCT g.name
FROM genres AS g
WHERE g.id IN
	(SELECT DISTINCT g.id
    FROM genres AS g
    INNER JOIN movies AS m ON g.id = m.genre_id
    INNER JOIN series AS s ON g.id = s.genre_id
    WHERE m.genre_id IS NOT NULL AND s.genre_id IS NOT NULL);

/*Ejercicio 6*/
SELECT DISTINCT g.name
FROM genres AS g
WHERE g.id NOT IN
	(SELECT DISTINCT g.id
    FROM genres AS g
    INNER JOIN series AS s ON g.id = s.genre_id
    WHERE s.genre_id IS NOT NULL);