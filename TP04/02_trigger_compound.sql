drop table TEMP_AFFICHAGE PURGE;

CREATE TABLE TEMP_AFFICHAGE(
           ID_AFFICHAGE   NUMBER(2),
           AFFICHAGE      VARCHAR2(200),
		   TYPE_OP        VARCHAR2(20) ); 
TRUNCATE TABLE TEMP_AFFICHAGE;
DROP SEQUENCE compteur;
CREATE SEQUENCE compteur START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE PACKAGE TriggerMoment AS
        v_compteur NUMBER :=0;
END TriggerMoment;
/

drop TRIGGER MiseAJourCategories;
CREATE  TRIGGER MiseAJourCategories
FOR UPDATE OR INSERT OR DELETE ON CATEGORIES
COMPOUND TRIGGER
--************************************************************
   BEFORE STATEMENT IS
--************************************************************
   v_type  varchar2(20) := ' ';
   BEGIN
     case  when INSERTING then v_type := 'INSERT';
		   when UPDATING then v_type := 'UPDATE';
		   when DELETING then v_type := 'DELETE';
	 end case;
     TriggerMoment.v_compteur := compteur.NEXTVAL;
     INSERT INTO TEMP_AFFICHAGE VALUES 
	  ( TriggerMoment.v_compteur,
         'BEFORE '||v_type||' niveau instruction    : compteur = '||
          TriggerMoment.v_compteur,v_type );
   END BEFORE STATEMENT;
--************************************************************
   AFTER STATEMENT IS
--************************************************************
   v_type  varchar2(20) := ' ';
   BEGIN
     case  when INSERTING then v_type := 'INSERT';
		   when UPDATING then v_type := 'UPDATE';
		   when DELETING then v_type := 'DELETE';
	 end case;
     TriggerMoment.v_compteur := compteur.NEXTVAL;
     INSERT INTO TEMP_AFFICHAGE VALUES 
	  ( TriggerMoment.v_compteur,
		'AFTER  '||v_type||' niveau instruction    : compteur = '||
          TriggerMoment.v_compteur,v_type);
   END AFTER STATEMENT;
--************************************************************
   BEFORE EACH ROW IS
--************************************************************
   v_type  varchar2(20) := ' ';
   BEGIN
     case  when INSERTING then v_type := 'INSERT';
		   when UPDATING then v_type := 'UPDATE';
		   when DELETING then v_type := 'DELETE';
	 end case;
     TriggerMoment.v_compteur := compteur.NEXTVAL;
     INSERT INTO TEMP_AFFICHAGE VALUES 
	  ( TriggerMoment.v_compteur,
	  'BEFORE '||v_type||' niveau enregistrement : compteur = '||
          TriggerMoment.v_compteur,v_type);
   END BEFORE EACH ROW;
--************************************************************
   AFTER EACH ROW IS
--************************************************************
   v_type  varchar2(20) := ' ';
   BEGIN
     case  when INSERTING then v_type := 'INSERT';
		   when UPDATING then v_type := 'UPDATE';
		   when DELETING then v_type := 'DELETE';
	 end case;
     TriggerMoment.v_compteur := compteur.NEXTVAL;
     INSERT INTO TEMP_AFFICHAGE VALUES 
	  ( TriggerMoment.v_compteur,
         'AFTER  '||v_type||' niveau enregistrement : compteur = '||
          TriggerMoment.v_compteur,v_type);
   END AFTER EACH ROW;
END MiseAJourCategories;
/

UPDATE CATEGORIES SET DESCRIPTION = ' ' WHERE ROWNUM < 3;
insert into categories values ( 11, 'Categorie 11','Categorie 11');

SELECT * FROM TEMP_AFFICHAGE;



