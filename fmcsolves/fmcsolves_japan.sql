SELECT A.id,A.name,A.countryId,(B.1st+C.2nd+D.3rd) AS Solves,E.best AS Single,ROUND(F.best/100,2) AS Average FROM
(SELECT id,name,countryId FROM Persons WHERE subid = 1 AND countryId = 'Japan') A
INNER JOIN
(SELECT personId,count(value1) AS 1st from Results WHERE eventId = '333fm' AND value1 NOT IN(0,-2) GROUP BY personId) B
ON A.id = B.personId
INNER JOIN
(SELECT personId,count(value2) AS 2nd from Results WHERE eventId = '333fm' AND value2 NOT IN(0,-2) GROUP BY personId) C
ON A.id = C.personId
INNER JOIN
(SELECT personId,count(value3) AS 3rd from Results WHERE eventId = '333fm' AND value3 NOT IN(0,-2) GROUP BY personId) D
ON A.id = D.personId 
INNER JOIN
(SELECT personId,eventId,best FROM RanksSingle WHERE eventId = '333fm') E
ON A.id = E.personId
LEFT OUTER JOIN
(SELECT personId,eventId,best FROM RanksAverage WHERE eventId = '333fm') F
ON A.id = F.personId
ORDER BY Solves DESC LIMIT 20;
