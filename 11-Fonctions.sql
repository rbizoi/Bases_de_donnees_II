CREATE OR REPLACE FUNCTION AffichePaysProduits
RETURN t_aff
IS
    t_p t_aff;
begin
   SELECT r_pays_prod_q(PAYS,PRODUIT,QUANTITE) 
   BULK COLLECT INTO t_p FROM 
        (SELECT PAYS,
                NOM_PRODUIT PRODUIT,
                SUM(DC.QUANTITE) QUANTITE,
                NTILE(100) OVER ( PARTITION BY PAYS
                                  ORDER BY SUM(DC.QUANTITE) ) NT
         FROM CLIENTS NATURAL JOIN COMMANDES 
                      NATURAL JOIN DETAILS_COMMANDES DC
                              JOIN PRODUITS USING(REF_PRODUIT)
         WHERE ANNEE = 2011 GROUP BY PAYS, NOM_PRODUIT)
   WHERE NT >= 98 ;
   return t_p;  
end AffichePaysProduits;
/


SELECT * FROM TABLE( AffichePaysProduits)
WHERE PAYS IN ( 'France','Italie');
