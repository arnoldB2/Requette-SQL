SELECT * FROM employe;
-- selection les prenom des employes donc le salaires est compris entre 14000 et 21500

SELECT prenom FROM employe 
WHERE salaire BETWEEN 14000 AND 21500;

-- avoir les noms des employes donc le nom est compris entre A et F 

SELECT nom FROM employe
WHERE nom BETWEEN 'A' AND 'F';

--prenom des employe donc la date contrat est entre 2000-01-01 et 2009-12-31 

SELECT prenom FROM employe
WHERE dateContrat BETWEEN '2000-01-01' AND '2009-12-31';

-- connaitre les pronoms des employes donc le salaire est soit 10000 soit 20000 

SELECT prenom FROM employe
WHERE salaire IN (10000,20000)

                          -- operateur de comparaison 

-- SELECTIONNE LES NOM ET PRENOM DES EMPLOYER DONC LE NOM COMMENCE PAR 'D' 

SELECT nom, prenom FROM employe
WHERE nom LIKE 'D%';

--SELECTIONNE LES NOM ET PRENOM DES EMPLOYER DONC LE NOM se termine PAR 'D' 

SELECT nom, prenom FROM employe
WHERE nom LIKE '%D';

--SELECTIONNE LES NOM ET PRENOM DES EMPLOYES DONC LE NOM CONTIENT PAR 'E' 
SELECT nom, prenom FROM employe
WHERE nom LIKE '%E%';


-- OPERATEURS LOGIQUES, ARITHMETIQUE ET CANCATENATION

-- SELECTIONNE LES NOM ET PRENOM DES EMPLOYE DONC LE SEXE EST M ET LE SALAIRE EST SUPERIEURE A 12000