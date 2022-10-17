declare
   cursor c_emp 
      ( model_fonction varchar2 := 'R%',
	    a_pays         varchar2 := 'France')
      is
      select nom,prenom,fonction,salaire
	  from employes
	  where fonction like model_fonction
	    and pays = a_pays
	  order by nom;
   v_emp  c_emp%rowtype;  
   i int := 0;
begin
   open c_emp(a_pays => 'Mexique'); --('fonc')
   loop
       fetch c_emp into v_emp;
	   exit when c_emp%notfound;
	   i := i+1;
       dbms_output.put_line(i||' '||
	      v_emp.nom||' '||v_emp.fonction);
   end loop;
   close c_emp;
end;
/   


declare
   cursor c_emp is
      select nom,prenom,fonction,salaire
	  from employes;
--   v_emp  c_emp%rowtype;  
   i int := 0;
begin
--   open c_emp;
   for v_emp in c_emp
   loop
       --fetch c_emp into v_emp;
	   --exit when c_emp%notfound;
	   i := i+1;
       dbms_output.put_line(i||' '||
	      v_emp.nom||' '||v_emp.fonction);
   end loop;
--   close c_emp;
end;
/   

declare
   i int := 0;
begin
   for v_emp in 
     ( select nom,prenom,fonction,salaire
	   from employes)
   loop
	   i := i+1;
       dbms_output.put_line(i||' '||
	      v_emp.nom||' '||v_emp.fonction);
   end loop;
end;
/   

begin
	for i in ( SELECT CLIENT, VILLE ,PAYS FROM DIM_CLIENTS)
	loop
		dbms_output.put_line( 'Client : '||i.CLIENT||
			' -- Localisé :'||i.VILLE||' '||i.PAYS);
	end loop;
end;
/

declare
	v_annee NUMBER(4) := &anne_du_calcul;
begin
	DELETE VENTES_CLIENTS WHERE ANNEE = v_annee;
	for i in ( select ANNEE, MOIS,	CODE_CLIENT,
				SUM(QUANTITE*PRIX_UNITAIRE) VENTE,
				SUM(QUANTITE*PRIX_UNITAIRE*REMISE) REMISE
				FROM COMMANDES NATURAL JOIN DETAILS_COMMANDES
				WHERE ANNEE = v_annee
				GROUP BY ANNEE,
				MOIS,
				CODE_CLIENT)
	loop
		INSERT INTO VENTES_CLIENTS VALUES i;
	end loop;
	COMMIT;
end;
/

BEGIN
	for v_clients in ( SELECT * FROM CLIENTS ) 
	loop
		dbms_output.put_line('Client -------'||v_clients.SOCIETE );
		for v_commandes in
				( SELECT NO_COMMANDE FROM COMMANDES A
				WHERE CODE_CLIENT = v_clients.CODE_CLIENT AND
				PORT > 3*( SELECT AVG(PORT) FROM COMMANDES B
				WHERE TRUNC(A.DATE_COMMANDE,'year') =
				TRUNC(B.DATE_COMMANDE,'year')))
		loop
			dbms_output.put_line('---'||v_commandes.NO_COMMANDE );
		end loop;
	end loop;
END;
/






declare 
   cursor c_ind (a_d1 date, a_d2 date)is
   select * from ind 
       where commande between a_d1 and a_d2;
   TYPE        t_indicateurs IS TABLE OF c_ind%ROWTYPE;
   t_ind       t_indicateurs;
   	   
begin
   open c_ind('01/01/1990','01/01/2013');
   loop
         fetch c_ind bulk collect into t_ind limit 10000;
         exit when c_ind%NOTFOUND;
   end loop;
   close c_ind;   
end;
/


