--MURDER CASE

/*A crime scene has taken place, and the detective needs our help, the detective
gave you the crime scene report, but you somehow lost it, you vaguely remember,
that the crime was a murder that occured sometime on jan 15th 2018 and that it took
place in SQL City.*/

--STAGE 1: Import all the necessary tables
CREATE TABLE "EVENT CHECK-IN" ("PERSON ID" INT, "EVENT ID" INT, "EVENT NAME" VARCHAR, "DATE" TEXT);

CREATE TABLE "GYM CHECK-IN" ("MEMBERSHIP ID" TEXT, "CHECK IN DATE" INT, "CHECK IN TIME" INT, "CHECK OUT TIME" INT);  

CREATE TABLE "GYM MEMBERS" ("ID" TEXT, "PERSON ID" INT, "NAME" VARCHAR, "MEMBERSHIP START DATE" INT, "MEMBERSHIP STATUS" VARCHAR);

CREATE TABLE "INTERVIEW" ("PERSON ID" INT, "TRANSCRIPT" VARCHAR);

CREATE TABLE "OUR SUSPECT" ("ID" INT, "AGE" INT, "HEIGHT" INT, "EYE COLOUR" VARCHAR, "HAIR COLOUR" VARCHAR, "GENDER" VARCHAR, "PLATE NUMBER" TEXT, "CAR MAKE" VARCHAR, "CAR MODEL" VARCHAR);

CREATE TABLE "PERSON" ("ID" INT, "NAME" VARCHAR, "LICENSE ID" INT, "ADDRESS NUMBER" INT, "ADDRESS STREET NAME" VARCHAR, "SSN" INT);

CREATE TABLE "SCENE REPORT" ("DATE" INT, "CRIME TYPE" VARCHAR, "DESCRIPTION" VARCHAR, "CITY" VARCHAR);

CREATE TABLE "DRIVERS LICENSE" ("ID" INT, "AGE" INT, "HEIGHT" INT, "EYE COLOUR" VARCHAR, "HAIR COLOUR" VARCHAR, "GENDER" VARCHAR, "PLATE NUMBER" TEXT, "CAR MAKE" VARCHAR, "CAR MODEL" VARCHAR);

--STAGE 2:
SELECT * FROM "SCENE REPORT"
WHERE "CITY" = 'SQL City'
AND "DATE" = '20180115'
AND "CRIME TYPE" = 'murder'

/*Security footage shows that there were 2 witnesses. 
The first witness lives at the last house on Northwestern Dr. 
The second witness, named Annabel, lives somewhere on Franklin Ave.*/

--STAGE 3:
SELECT * FROM "PERSON" 
WHERE "ADDRESS STREET NAME" = 'Northwestern Dr'
ORDER BY "ADDRESS NUMBER" DESC
LIMIT 5
/*First witness ID;14887||NAME;Morty Schapiro||LICENSE ID;118009||	
ADDRESS NUMBER;4919	|| ADDDRESS STREET NAME;Northwestern Dr|| SSN;111564949*/

SELECT * FROM "PERSON"
WHERE "NAME" LIKE '%Annabel%'
AND "ADDRESS STREET NAME" = 'Franklin Ave'
/*Second witness ID;16371|| NAME;Annabel Miller||	LICENSE ID;490173||	
ADDRESS NUMBER;103|| ADDRESS STREET NAME;Franklin Ave|| SSN;318771143*/

--STAGE 4
SELECT * FROM "INTERVIEW"
WHERE "PERSON ID" = 16371 
/*"I saw the murder happen, and 
I recognized the killer from my gym when I was working out last week on January the 9th."*/

SELECT * FROM "INTERVIEW"
WHERE "PERSON ID" = 14887
/*"I heard a gunshot and then saw a man run out. He had a Get Fit Now Gym bag. 
The membership number on the bag started with 48Z. Only gold members have those bags. 
The man got into a car with a plate that included H42W."*/

--STAGE 5
SELECT * FROM "GYM MEMBERS" 
WHERE "MEMBERSHIP STATUS" = 'gold'
AND "ID" LIKE '48Z%'
/* Based don this, our suspects are Jeremy Germuska with ID;48Z7A|| Person ID;28819 
AND Jeremy Bowers with ID;48Z55|| Person ID; 67318*/

SELECT * FROM "GYM CHECK-IN"
WHERE "CHECK IN DATE" = 20180109
AND "MEMBERSHIP ID" IN ('48Z7A', '48Z55');
/*According to this, both suspect were present at the gym Jan 9th*/

SELECT * FROM "DRIVERS LICENSE" AS "DL"
LEFT JOIN "PERSON" AS "P"
ON "DL"."ID" = "P"."LICENSE ID"
WHERE "PLATE NUMBER" LIKE '%H42W%'
AND "P"."ID" IN (67318, 28819)
/*According to this, Jeremy Bowers is the murderer*/

--STAGE 6
SELECT * FROM "INTERVIEW"
WHERE "PERSON ID" = 67318
/*According to this, Jeremy Bowers is the murderer
"I was hired by a woman with a lot of money. 
I don't know her name but I know she's around 5'5 (65) or 5'7 (67). 
She has red hair and she drives a Tesla Model S. 
I know that she attended the SQL Symphony Concert 3 times in December 2017."*/

--STAGE 7
SELECT * FROM "DRIVERS LICENSE" AS "DL"
LEFT JOIN "PERSON" AS "P" ON "DL"."ID" = "P"."LICENSE ID"
LEFT JOIN "EVENT CHECK-IN" AS "EC" ON "P"."ID" = "EC"."PERSON ID"
WHERE "HEIGHT" BETWEEN 65 AND 67
AND "HAIR COLOUR" = 'red'
AND "CAR MAKE" = 'Tesla'
AND "CAR MODEL" = 'Model S'
AND "EVENT NAME" = 'SQL Symphony Concert'
AND "DATE" BETWEEN '20171201' AND '20171231'
/*According to this, Miranda Priestly hired Jeremy Bowers to commit murder*/



