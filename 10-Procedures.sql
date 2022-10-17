----------------------------------------------------------------- 
SET VERIFY OFF SERVEROUTPUT ON
CREATE OR REPLACE PROCEDURE AfficheUnites
   ( a_cat  PRODUITS.CODE_CATEGORIE%TYPE := 2, 
     a_four PRODUITS.NO_FOURNISSEUR%TYPE := 2)
IS
    v_cat      PRODUITS.CODE_CATEGORIE%TYPE := a_cat;
    v_four     PRODUITS.NO_FOURNISSEUR%TYPE := a_four;
begin
   for v_produit in ( SELECT * FROM PRODUITS
                      WHERE CODE_CATEGORIE = v_cat
                       AND NO_FOURNISSEUR = v_four) 
   loop
      if v_produit.UNITES_STOCK > 0 then
         dbms_output.put_line('Les unités en stock '||
                        v_produit.NOM_PRODUIT||' : '||
                        v_produit.UNITES_STOCK);
      else 
         dbms_output.put_line('Les unités commandées '||
                        v_produit.NOM_PRODUIT||' : '||
                        v_produit.UNITES_COMMANDEES);
      end if;    
   end loop;
end;
/