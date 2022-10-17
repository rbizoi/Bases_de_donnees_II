--SQL%FOUND
begin
     UPDATE DETAILS_COMMANDES
         SET PRIX_UNITAIRE = PRIX_UNITAIRE * 1.05
     WHERE NO_COMMANDE = 11077;
     if SQL%FOUND then  
         COMMIT;
     end if;
end;
/

--SQL%NOTFOUND 
begin
     DELETE DETAILS_COMMANDES WHERE NO_COMMANDE = 215003;
     if SQL%NOTFOUND then 
           dbms_output.put_line('Non trouvé');
     else              
           dbms_output.put_line('Trouvé');
     end if;
end;
/

--SQL%ROWCOUNT 
begin
     UPDATE DETAILS_COMMANDES
         SET PRIX_UNITAIRE = PRIX_UNITAIRE * 1.05
     WHERE NO_COMMANDE = 214999;
     if SQL%FOUND then
        dbms_output.put_line('Enregistrements modifiés : '
                              ||SQL%ROWCOUNT);
        COMMIT;                      
     else
        dbms_output.put_line('Aucun enregistrement trouvé');
     end if;
end;
/
