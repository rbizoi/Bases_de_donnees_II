CREATE OR REPLACE TRIGGER TRG_update_employes
BEFORE UPDATE ON employes 
FOR EACH ROW 
BEGIN
  RAISE_APPLICATION_ERROR ( -20000, ' aucune modification de la table n''est possible');
END;
/

update employes set salaire = salaire *1.2;

CREATE OR REPLACE TRIGGER TRG_update_employes
BEFORE UPDATE ON employes 
BEGIN
  if to_char(sysdate,'hh24') > '18' 
  then  
    RAISE_APPLICATION_ERROR ( -20000, ' aucune modification de la table n''est possible ');
  end if;
END;
/

CREATE OR REPLACE TRIGGER TRG_update_employes
BEFORE UPDATE ON employes 
--FOR EACH ROW 
BEGIN
  RAISE_APPLICATION_ERROR ( -20000, ' aucune modification de la table n''est possible');
END;
/

update employes set salaire = salaire *1.2;

SELECT TO_CHAR(SYSDATE,'hh24') FROM DUAL;

CREATE OR REPLACE TRIGGER TRG_update_employes
BEFORE UPDATE ON employes 
BEGIN
  if to_number(to_char(sysdate,'hh24')) > 18 then  
    RAISE_APPLICATION_ERROR ( -20000, ' aucune modification de la table n''est possible ');
  else
    DBMS_OUTPUT.PUT_LINE(TO_CHAR(SYSDATE,'hh24'));
  end if;
END;
/

SET SERVEROUTPUT ON

CREATE OR REPLACE VIEW CumulVentesParClient AS
        SELECT EXTRACT ( YEAR  FROM DATE_COMMANDE) ANNEE,
               EXTRACT ( MONTH FROM DATE_COMMANDE) MOIS,
               CODE_CLIENT,
               SUM(QUANTITE*PRIX_UNITAIRE) VENTE,
               SUM(QUANTITE*PRIX_UNITAIRE*REMISE) REMISE,
               SUM(QUANTITE) QUANTITE,
               SUM(PORT) PORT
        FROM   COMMANDES NATURAL JOIN DETAILS_COMMANDES
        GROUP BY EXTRACT ( YEAR  FROM DATE_COMMANDE),
                 EXTRACT ( MONTH FROM DATE_COMMANDE),
                 CODE_CLIENT
        ORDER BY EXTRACT ( YEAR  FROM DATE_COMMANDE),
                 EXTRACT ( MONTH FROM DATE_COMMANDE),
                 CODE_CLIENT;

SELECT count(*) over () "NbTotal", c.* 
FROM CumulVentesParClient c 
WHERE ANNEE = 2010 AND MOIS = 5;

SELECT count(*) over () "NbTotal", c.* 
FROM COMMANDES c 
WHERE CODE_CLIENT = 'WHITC' 
  AND EXTRACT(YEAR  FROM DATE_COMMANDE) = 2010;

DELETE CumulVentesParClient WHERE CODE_CLIENT = 'WHITC';

CREATE OR REPLACE TRIGGER CumulVentesParClient
INSTEAD OF DELETE ON CumulVentesParClient
BEGIN 
   NULL; 
   dbms_output.put_line('Il n''est pas possible de supprimer');
END CumulVentesParClient;
/

CREATE OR REPLACE TRIGGER CumulVentesParClient
INSTEAD OF DELETE ON CumulVentesParClient
BEGIN 
    DELETE DETAILS_COMMANDES 
    WHERE NO_COMMANDE IN ( SELECT NO_COMMANDE FROM COMMANDES
          WHERE CODE_CLIENT = :OLD.CODE_CLIENT AND 
          EXTRACT ( YEAR  FROM DATE_COMMANDE) = :OLD.ANNEE AND 
          EXTRACT ( MONTH FROM DATE_COMMANDE) = :OLD.MOIS);  
    DELETE COMMANDES
          WHERE CODE_CLIENT = :OLD.CODE_CLIENT AND 
          EXTRACT ( YEAR  FROM DATE_COMMANDE) = :OLD.ANNEE AND 
          EXTRACT ( MONTH FROM DATE_COMMANDE) = :OLD.MOIS;
    dbms_output.put_line( :OLD.CODE_CLIENT||' '||
                          :OLD.ANNEE||' '|| :OLD.MOIS); 
END CumulVentesParClient;
/

DELETE CumulVentesParClient
WHERE CODE_CLIENT = 'WHITC' AND ANNEE = 2010;

SELECT count(*) over () "NbTotal", c.* 
FROM COMMANDES c 
WHERE CODE_CLIENT = 'WHITC' 
  AND EXTRACT ( YEAR  FROM DATE_COMMANDE) = 2010;




