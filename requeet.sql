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

                             -- exercice 1

--Sélectionnez le nom et le prénom de l'employé masculin qui gagne plus de 15000.

SELECT nom, prenom FROM employe
WHERE sexe = 'M' AND salaire > 15000;

--Sélectionnez le prénom des 3 employés qui gagnent le plus. Tri par salaire descendant.

SELECT prenom FROM employe
--ORDER BY salaire DESC LIMIT 3

--Sélectionnez le plus petit salaire aliasé en salaireMin
SELECT salaire AS salaireMin 
FROM employe



SELECT 
a.nom,
a.prenom,
a.date_naissance,
m.idMaitre_apprentissage,
m.nom,
m.prenom,
m.dateNaissance
FROM apprenti a
INNER JOIN maitre_apprentissage m ON a.idApprenti=m.idMaitre_apprentissage

SELECT * FROM apprenti

SELECT * FROM contrat
INNER JOIN apprenti 
      ON apprenti.idApprenti=contrat.id_Contrat; 


SELECT * FROM contrat
INNER JOIN apprenti ON apprenti.idApprenti=contrat.Apprenti_idApprenti
INNER JOIN employeur ON employeur.numSiret=contrat.Employeur_numSiret
INNER JOIN renumeration ON renumeration.idRenumeration=renumeration.Contrat_id_Contrat
INNER JOIN ecole ON ecole.numSiret=contrat.Ecole_numSiret
INNER join formation ON formation.idFormation=apprenti.Formation_idFormation
INNER JOIN maitre_apprentissage_has_apprenti ON maitre_apprentissage_has_apprenti.Maitre_apprentissage_idMaitre_apprentissage =maitre_apprentissage_has_apprenti.Apprenti_idApprenti





SELECT 
    N.part, 
	N.supplier,
	N.plant,
	N.année,
	N.total_quantite,
	N.WEIGHTED_REF_PRICE,
	N.W_A_D_Price,
	SUM((N.W_A_D_Price - N.WEIGHTED_REF_PRICE)*N.total_quantite)  AS SAVING

FROM (
SELECT 
    A.part, 
	A.supplier,
	A.plant,
	A.prix,
	A.année,
	A.total_quantite,
	A.WEIGHTED_REF_PRICE,
	CASE 
		      WHEN  SUM(A.WEIGHTED_REF_PRICE*A.total_quantite)>0
		        
		               THEN (SUM(A.WEIGHTED_REF_PRICE*A.total_quantite)/
											SUM(A.WEIGHTED_REF_PRICE*A.total_quantite)*100)
			ELSE 0 
			END  AS W_A_D_Price
	
FROM (
SELECT DISTINCT 

    B.part, 
	B.supplier,
	B.plant,
	B.prix,
	B.WEIGHTED_REF_PRICE,
	B.année,
	B.DD,
	sum(B.QTY_MVT)  AS total_quantite, 
	min(B.WEIGHTED_REF_PRICE) AS  dernier_Prix 

FROM 
(SELECT DISTINCT 
		 af.SN_ERP_PARTNUMBER AS part,
		af.sn_supplier AS supplier,
		af.SN_PLANT AS plant,
		af.PRICE_UNIT_MVT AS prix,
		af.QTY_MVT,
		af.date_mvt, 
	  EXTRACT (YEAR FROM af.date_mvt) AS année,
	  min(af.date_mvt)  AS DD,
	  sum(ar.PRICE_MODIFIED*ar.SHARE_MODIFIED*rate/100) AS WEIGHTED_REF_PRICE
  FROM  PRICE_AVERAGE.AGG_FACT af 
        

						INNER JOIN PRICE_AVERAGE.MD_ERP_PARTNUMBER mep ON mep.SN_ERP_PARTNUMBER = af.SN_ERP_PARTNUMBER
						INNER JOIN PRICE_AVERAGE.PLANT p ON p.SN_PLANT= af.sn_plant						
						INNER JOIN PRICE_AVERAGE.AIP_REFPRICE ar ON ar.PRICE_MODIFIED =af.PRICE_UNIT_MVT 
					    INNER JOIN PRICE_AVERAGE.MD_SUPPLIER ms ON ms.SN_SUPPLIER = af.SN_SUPPLIER
						INNER JOIN PRICE_AVERAGE.MD_CURRENCY cu ON cu.SN_CURRENCY = af.SN_CURRENCY
						INNER JOIN PRICE_AVERAGE.RATE r ON R.SN_CURRENCY_REF = cu.SN_CURRENCY AND r.SN_CURRENCY_DEM =9
						--INNER JOIN PRICE_AVERAGE.REF_EXCH_RATE rer ON rer.SN_CURRENCY_REF = cu.SN_CURRENCY AND rer.SN_CURRENCY_DEM =9 
						
						GROUP BY af.SN_PLANT,af.SN_ERP_PARTNUMBER
						          ,af.sn_supplier
						          ,ar.PRICE_MODIFIED 
	                              ,af.PRICE_UNIT_MVT 
	                              ,af.QTY_MVT 
						         ,af.date_mvt
						ORDER BY 3 DESC)B
						WHERE B.date_mvt BETWEEN (B.date_mvt-90) AND B.date_mvt
AND EXTRACT (YEAR FROM B.date_mvt)= EXTRACT (YEAR FROM B.DD)

						
							GROUP BY 
							 B.part,
							B.supplier,
							B.plant,
							B.prix,
							B.WEIGHTED_REF_PRICE,
							B.année,
							B.DD
						ORDER BY 3 DESC)A
						
						
						GROUP BY A.part, 
								A.supplier,
								A.plant,
								A.prix,
								A.année,
								A.WEIGHTED_REF_PRICE,
								A.total_quantite
	
						ORDER BY 3 DESC)N
						
					GROUP BY 
									
				    N.part, 
					N.supplier,
					N.plant,
					N.année,
					N.total_quantite,
					N.WEIGHTED_REF_PRICE,
					N.W_A_D_Price
	ORDER BY 3 DESC;


/* requete pour la problematique 4

	SELECT r.date_ouv_cnt, 
       r.idperson, 
       r.sroring, 
       r.valid_from, 
       r.valid_to 
             FROM ( 
                  SELECT
                       r1.date_ouv_cnt , 
                       r1.idperson, 
                       r1.sroring, 
                       r1.valid_from, 
                       r1.valid_to 
                       FROM ( 
                             SELECT DISTINCT
                                     p.idPerson, 
                                     p.idPerson2, 
                                     p.StatutCpt, 
                                     p.Date_ouv_cnt, 
                                     ps.Sroring, 
                                     ps.Valid_from, 
                                     ps.Valid_to 
                                     FROM personaccount p 
                                     INNER JOIN person_scoring_rish ps on ps.PERSONACCOUNT_idPerson=p.idPerson 
                                     WHERE p.StatutCpt= "FERMER" AND p.Date_ouv_cnt IS NOT NULL)r1 
                                     )r WHERE
                                        r.valid_to AND r.Sroring= "high" */




/*pour la problematique 6*/

WITH COMPTE_FERMER_HIGH AS
(
SELECT pc.productid,
       pc.LASTNAME,
       pc.FIRSTNAME,
       pac.STATUT,
       pac.DATE_CREATE,
       pac.DATE_FERMET,
       psrc.SCRORING ,
       psrc.VALID_FROM,
       psrc.VALID_TO
FROM USER_ARND.PERSONN_SCORING_RISH_CSV psrc JOIN USER_ARND.PERSON_CSV pc ON psrc.PERSONID
= pc.PRODUCTID
JOIN USER_ARND.PERSON_ACCOUNT_CSV pac ON
pc.PRODUCTID =pac.PERSONID
WHERE pac.STATUT NOT IN (10,11) AND psrc.SCRORING = 'HIGH'
)
SELECT * FROM COMPTE_FERMER_HIGH f
			
