--Nombre de clients
SELECT count(CLI_ID)
FROM T_CLIENT

--Les clients triés sur le titre et le nom
SELECT *
FROM T_CLIENT
ORDER BY TIT_CODE, CLI_NOM

--Les clients triés sur le libellé du titre et le nom
SELECT *
FROM T_TITRE,T_CLIENT
ORDER BY TIT_LIBELLE, CLI_NOM

--Les clients commençant par 'B'
SELECT *
FROM T_CLIENT
WHERE UPPER(CLI_NOM) LIKE 'B%'

--Les clients homonymes
SELECT  *
FROM T_CLIENT A
WHERE EXISTS (SELECT *
              FROM T_CLIENT B
              WHERE (A.CLI_ID <> B.CLI_ID)
              AND (A.CLI_NOM=B.CLI_NOM)
)

--Nombre de titres différents
SELECT COUNT(TIT_CODE)
FROM T_TITRE

--Nombre d'enseignes
SELECT COUNT(CLI_ENSEIGNE)
FROM T_CLIENT

--Les clients qui représentent une enseigne 
SELECT *
FROM T_CLIENT
WHERE CLI_ENSEIGNE IS NOT NULL

--Les clients qui représentent une enseigne de transports
SELECT *
FROM T_CLIENT
WHERE CLI_ENSEIGNE IS NOT NULL
AND UPPER(CLI_ENSEIGNE) LIKE '%TRANSPORT%'

--Nombre d'hommes,Nombres de femmes, de demoiselles, Nombres de sociétés

SELECT(SELECT COUNT(*) FROM T_CLIENT WHERE TIT_CODE = 'M.') AS M,
(SELECT COUNT(*) FROM T_CLIENT WHERE TIT_CODE = 'Mme.') AS Mme,
(SELECT COUNT(*) FROM T_CLIENT WHERE TIT_CODE = 'Melle.') AS Melle

--Nombre d''emails
SELECT COUNT(EML_ID)
FROM T_EMAIL

--Client sans email 
SELECT *
FROM T_CLIENT
LEFT JOIN T_EMAIL ON T_CLIENT.CLI_ID = T_EMAIL.CLI_ID
WHERE T_EMAIL.CLI_ID IS NULL

--Clients sans téléphone 
SELECT *
FROM T_CLIENT
LEFT JOIN T_TELEPHONE ON T_CLIENT.CLI_ID = T_TELEPHONE.CLI_ID
WHERE T_TELEPHONE.CLI_ID IS NULL

--Les phones des clients
SELECT *
FROM T_CLIENT
INNER JOIN T_TELEPHONE ON T_CLIENT.CLI_ID = T_TELEPHONE.CLI_ID

--Ventilation des phones par catégorie
SELECT(SELECT COUNT(*) FROM T_TELEPHONE WHERE TYP_CODE = 'TEL') AS TEL,
(SELECT COUNT(*) FROM T_TELEPHONE WHERE TYP_CODE = 'FAX') AS FAX,
(SELECT COUNT(*) FROM T_TELEPHONE WHERE TYP_CODE = 'GSM') AS GSM

--Les clients ayant plusieurs téléphones

--Clients sans adresse:
SELECT *
FROM T_CLIENT
LEFT JOIN T_ADRESSE ON T_CLIENT.CLI_ID = T_ADRESSE.CLI_ID
WHERE T_ADRESSE.CLI_ID IS NULL

--Clients sans adresse mais au moins avec mail ou phone 

--Dernier tarif renseigné
SELECT MAX(TRF_DATE_DEBUT)
FROM T_TARIF

--Tarif débutant le plus tôt 
SELECT MIN(TRF_DATE_DEBUT)
FROM T_TARIF

--Différentes Années des tarifs

--Nombre de chambres de l'hotel 
SELECT COUNT(CHB_ID)
FROM T_CHAMBRE

--Nombre de chambres par étage
SELECT *
FROM T_CHAMBRE
GROUP BY CHB_ETAGE

--Chambres sans telephone
SELECT *
FROM T_CHAMBRE
WHERE CHB_POSTE_TEL IS NULL

--Existence d'une chambre n°13 ?
SELECT *
FROM T_CHAMBRE
WHERE CHB_NUMERO = 13

--Chambres avec sdb
SELECT *
FROM T_CHAMBRE
WHERE CHB_BAIN= 1

--Chambres avec douche
SELECT *
FROM T_CHAMBRE
WHERE CHB_DOUCHE= 1

--Chambres avec WC
SELECT *
FROM T_CHAMBRE
WHERE CHB_WC= 1

--Chambres sans WC séparés
SELECT *
FROM T_CHAMBRE
WHERE CHB_WC= 0

--Quels sont les étages qui ont des chambres sans WC séparés ?
SELECT CHB_ETAGE
FROM T_CHAMBRE
WHERE CHB_WC= 0

--Nombre d'équipements sanitaires par chambre trié par ce nombre d'équipement croissant
SELECT (CHB_BAIN+CHB_DOUCHE+CHB_WC)AS SANITAIRE, CHB_ID
FROM T_CHAMBRE
ORDER BY SANITAIRE

--Chambres les plus équipées et leur capacité
SELECT *
FROM T_CHAMBRE
ORDER BY CHB_COUCHAGE DESC

--Repartition des chambres en fonction du nombre d'équipements et de leur capacité
SELECT (CHB_BAIN+CHB_DOUCHE+CHB_WC+CHB_COUCHAGE)AS SANITAIRE_ET_CAPACITER, CHB_ID
FROM T_CHAMBRE
ORDER BY SANITAIRE_ET_CAPACITER

--Nombre de clients ayant utilisé une chambre
SELECT CLI_ID
FROM T_FACTURE
GROUP BY CLI_ID

--Clients n'ayant jamais utilisé une chambre (sans facture)

--Nom et prénom des clients qui ont une facture
SELECT CLI_NOM, CLI_PRENOM
FROM T_CLIENT
INNER JOIN T_FACTURE ON T_CLIENT.CLI_ID = T_FACTURE.CLI_ID
GROUP BY CLI_NOM, CLI_PRENOM

--Nom, prénom, telephone des clients qui ont une facture
SELECT CLI_NOM, CLI_PRENOM, TEL_NUMERO
FROM T_CLIENT, T_TELEPHONE
INNER JOIN T_FACTURE ON T_CLIENT.CLI_ID = T_FACTURE.CLI_ID
GROUP BY CLI_NOM, CLI_PRENOM

--Attention si email car pas obligatoire : jointure externe

--Adresse où envoyer factures aux clients

--Répartition des factures par mode de paiement (libellé)

--Répartition des factures par mode de paiement 

--Différence entre ces 2 requêtes ? 

--Factures sans mode de paiement 

--Repartition des factures par Années

--Repartition des clients par ville

--Montant TTC de chaque ligne de facture (avec remises)

--Classement du montant total TTC (avec remises) des factures

--Tarif moyen des chambres par années croissantes

--Tarif moyen des chambres par étage et années croissantes

--Chambre la plus cher et en quelle année

--Chambre la plus cher par année 

--Clasement décroissant des réservation des chambres 

--Classement décroissant des meilleurs clients par nombre de réservations

--Classement des meilleurs clients par le montant total des factures

--Factures payées le jour de leur édition

--Facture dates et Délai entre date de paiement et date d'édition de la facture