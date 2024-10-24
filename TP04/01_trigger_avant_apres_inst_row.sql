DROP TABLE TEMP_AFFICHAGE;

CREATE TABLE TEMP_AFFICHAGE(
           ID_AFFICHAGE   NUMBER(2),
           AFFICHAGE      VARCHAR2(200));
           
TRUNCATE TABLE TEMP_AFFICHAGE;
DROP SEQUENCE compteur;
CREATE SEQUENCE compteur START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE PACKAGE TriggerMoment AS
        v_compteur NUMBER :=0;
END TriggerMoment;
/

CREATE OR REPLACE TRIGGER AvantMiseAJour
BEFORE UPDATE ON CATEGORIES
BEGIN
 --   TriggerMoment.v_compteur :=  compteur.NEXTVAL;
    INSERT INTO TEMP_AFFICHAGE VALUES 
    ( compteur.NEXTVAL,
        'BEFORE UPDATE niveau instruction    : compteur = '||
         TriggerMoment.v_compteur);
   TriggerMoment.v_compteur := TriggerMoment.v_compteur + 1;
END AvantMiseAJour;
/

CREATE OR REPLACE TRIGGER ApresMiseAJour
AFTER UPDATE ON CATEGORIES
BEGIN
    INSERT INTO TEMP_AFFICHAGE VALUES ( compteur.NEXTVAL,
        'AFTER  UPDATE niveau instruction    : compteur = '||
         TriggerMoment.v_compteur);
    TriggerMoment.v_compteur := TriggerMoment.v_compteur + 1;
END ApresMiseAJour;
/

CREATE OR REPLACE TRIGGER AvantMiseAJourEnregistrement
BEFORE UPDATE ON CATEGORIES
FOR EACH ROW
BEGIN
    INSERT INTO TEMP_AFFICHAGE VALUES ( 
    compteur.NEXTVAL,
        'BEFORE UPDATE niveau enregistrement : compteur = '||
         TriggerMoment.v_compteur);
    TriggerMoment.v_compteur := TriggerMoment.v_compteur + 1;
END AvantMiseAJourEnregistrement;
/

CREATE OR REPLACE TRIGGER ApresMiseAJourEnregistrement
AFTER UPDATE ON CATEGORIES
FOR EACH ROW
BEGIN
    INSERT INTO TEMP_AFFICHAGE VALUES ( 
    compteur.NEXTVAL,
        'AFTER  UPDATE niveau enregistrement : compteur = '||
         TriggerMoment.v_compteur);
 TriggerMoment.v_compteur := 
      TriggerMoment.v_compteur + 1;
END ApresMiseAJourEnregistrement;
/

UPDATE CATEGORIES SET DESCRIPTION = ' ' 
WHERE ROWNUM < 4;

SELECT * FROM TEMP_AFFICHAGE;
