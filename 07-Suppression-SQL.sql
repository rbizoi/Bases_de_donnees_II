CREATE OR REPLACE PROCEDURE AugmenterSalaire
IS
     CURSOR c_employe IS SELECT NOM,PRENOM,FONCTION,SALAIRE,COMMISSION
             FROM EMPLOYES FOR UPDATE OF SALAIRE, COMMISSION;
begin                         
  for v_employe in c_employe loop     
      case v_employe.FONCTION
      when 'Représentant(e)' then
          UPDATE EMPLOYES SET SALAIRE = SALAIRE * 1.25
                 WHERE CURRENT OF c_employe;
      else
          UPDATE EMPLOYES SET SALAIRE = SALAIRE * 1.1
                 WHERE CURRENT OF c_employe;
      end case;
  end loop;
end AugmenterSalaire;
/

begin AugmenterSalaire; end;


begin AugmenterSalaire();end;
/ 

CREATE OR REPLACE PROCEDURE SumSalaires IS
   v_sum EMPLOYES.SALAIRE%TYPE;
begin
   SELECT SUM( SALAIRE ) INTO v_sum FROM EMPLOYES;
   dbms_output.put_line( v_sum);
end;   
/

CALL SumSalaires();


EXECUTE SumSalaires();

EXEC SumSalaires();


