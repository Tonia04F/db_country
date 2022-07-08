-- 1 Selezionare tutte le nazioni il cui nome inizia con la P e la cui area è maggiore di 1000 kmq
SELECT *
FROM countries c  
WHERE c.name  LIKE 'P%' AND c.area >= 1000;

-- 2. Selezionare le nazioni il cui national day è avvenuto più di 100 anni fa
SELECT *
FROM `countries`  
WHERE TIMESTAMPDIFF (YEAR, national_day, CURDATE()) < 100;


-- 3. Selezionare il nome delle regioni del continente europeo, in ordine alfabetico
SELECT*
FROM regions r 
INNER JOIN continents c ON r.continent_id  = c.continent_id 
WHERE c.continent_id = 4
ORDER BY r.name;

-- 4. Contare quante lingue sono parlate in Italia
SELECT COUNT(l.language_id) 
FROM languages l 
INNER JOIN country_languages cl ON l.language_id = cl.language_id 
INNER JOIN countries c ON c.country_id =cl.country_id 
WHERE c.name = 'italy'

-- 5. Selezionare quali nazioni non hanno un national day
SELECT*
FROM countries c 
WHERE c.national_day IS NULL;

-- 6. Per ogni nazione selezionare il nome, la regione e il continente
SELECT*
FROM countries c  
INNER JOIN regions r ON c.region_id = r.region_id 
INNER JOIN continents c2 ON r.continent_id = c2.continent_id 

-- 7. Modificare la nazione Italy, inserendo come national day il 2 giugno 1946
update countries c set national_day = '1946-06-02' 
WHERE c.name ='italy';

-- 8. Per ogni regione mostrare il valore dell'area totale 
SELECT SUM(c.area) as area_totale, r.name 
FROM regions r
INNER JOIN countries c ON r.region_id  = c.region_id 
GROUP BY r.name 
ORDER BY area_totale DESC ;

-- 9. Selezionare le lingue ufficiali dell'Albania
SELECT c.name, l.`language` 
FROM `countries` c
INNER JOIN `country_languages` c_l
ON c.country_id = c_l.country_id 
INNER JOIN `languages` l 
ON l.language_id = c_l.language_id 
WHERE c.name LIKE 'Albania' AND c_l.official IS TRUE ;


-- 10. Selezionare il Gross domestic product (GDP) medio dello United Kingdom tra il 2000 e il 2010
SELECT c.name , AVG(cs.gdp) as media_gdp
FROM  countries c 
INNER JOIN country_stats cs  ON c.country_id = cs.country_id 
WHERE c.name = 'unite kingdom' AND cs.`year` >= 2000 AND cs.`year` <=2010  -- non funziona!
GROUP BY c.name 

-- 11. Selezionare tutte le nazioni in cui si parla hindi, ordinate dalla più estesa alla meno estesa
SELECT *
FROM `countries` c
INNER JOIN `country_languages` cl
ON c.country_id = cl.country_id
INNER JOIN `languages` l 
ON l.language_id = cl.language_id
WHERE l.`language` LIKE 'Hindi'
ORDER BY c.area DESC;


-- 12. Per ogni continente, selezionare il numero di nazioni con area superiore ai 10.000 kmq ordinando i risultati a partire dal continente che ne ha di più
SELECT c2.name , c2.area 
FROM continents c 
INNER JOIN regions r ON c.continent_id  = r.continent_id 
INNER JOIN countries c2 ON c2.region_id 
WHERE c2.area > 10000
ORDER BY c2.area desc;











