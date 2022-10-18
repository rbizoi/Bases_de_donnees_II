declare
   v_nom EMPLOYES.NOM%TYPE;
   v_sal EMPLOYES.SALAIRE%TYPE;
   v_avg EMPLOYES.SALAIRE%TYPE;
begin
   SELECT NOM, SALAIRE,
       ( SELECT AVG( SALAIRE) FROM EMPLOYES
          WHERE FONCTION LIKE 'Rep%') AVG_SAL INTO v_nom, v_sal, v_avg
          FROM EMPLOYES WHERE NO_EMPLOYE = 4;
   if  v_sal > v_avg then    
       dbms_output.put_line( v_nom );    
       dbms_output.put_line( 'Salaire '||v_sal
                             ||' supérieur à la moyenne');
   end if;
end;
/

declare
     v_employe EMPLOYES%ROWTYPE;
begin
    SELECT * INTO v_employe FROM EMPLOYES WHERE NO_EMPLOYE = 2;
    IF v_employe.COMMISSION > 0 THEN    
       dbms_output.put_line( 'Salaire : '||
               v_employe.SALAIRE + v_employe.COMMISSION);
    ELSE 
       dbms_output.put_line( 'Salaire : '||v_employe.SALAIRE);
    END IF;
end;
/

set verify off
set serveroutput on
begin
 if &&valeur < 15 then
            dbms_output.put_line('**** &&valeur < 15 ****');
 elsif &&valeur < 100 then
            dbms_output.put_line('**** &&valeur < 100 ****');
 else
            dbms_output.put_line('**** &&valeur >= 100 ****');
 end if;
end;
/


/*-------------------------*/
--CASE 

declare
    v_arg  NUMBER(2) := &valeur;
begin
   case v_arg
       when 1 then dbms_output.put_line( 'La valeur saisie est : 1');
       when 2 then dbms_output.put_line( 'La valeur saisie est : 2');       
       when 3 then dbms_output.put_line( 'La valeur saisie est : 3');  
       else        dbms_output.put_line( 'Toute autre valeur.');         
   end case;          
end;
/


declare
   v_valeur number := to_char( sysdate, 'ssss');
begin
   case
   when MOD(v_valeur,2)=0 then
       dbms_output.put_line( 'La valeur : '||v_valeur
                            ||' est un multiple de 2');
   when MOD(v_valeur,3)=0 then
       dbms_output.put_line( 'La valeur : '||v_valeur
                            ||' est un multiple de 3');
   when MOD(v_valeur,5)=0 then
       dbms_output.put_line( 'La valeur : '||v_valeur
                            ||' est un multiple de 5');
   else
       dbms_output.put_line( 'Toute autre valeur.');
   end case;
end;
/



/*-------------------------*/
--LOOP 

declare
   v_compteur number := 0;
begin
   <<BOUCLE_INCREMENT>>
   loop
       v_compteur := v_compteur + 1;
       dbms_output.put_line( 'Passage numéro : '||v_compteur);
       exit BOUCLE_INCREMENT when v_compteur > 3;
   end loop;
end;
/

--continue
declare
   v_compteur number(2) := 0;
begin
   loop
      v_compteur := v_compteur + 1;
      exit when v_compteur > 6;
      continue when v_compteur between 3 and 5;
      dbms_output.put_line ('Traitement index ='||
                               to_char (v_compteur));
   end loop;
end;
/

--exit
declare
   v_compteur number(2) := 0;
begin
   loop
      continue when v_compteur between 3 and 5;
      v_compteur := v_compteur + 1;
      exit when v_compteur > 7;
      dbms_output.put_line ('Traitement index ='||
                               to_char (v_compteur));
   end loop;
end;
/


--while
declare
   TYPE TABLEAU_EMPLOYE IS TABLE OF EMPLOYES%ROWTYPE
             INDEX BY BINARY_INTEGER;
   t_emp TABLEAU_EMPLOYE;
   v_compteur     NUMBER(2) := 0;
begin
   SELECT * BULK COLLECT INTO t_emp FROM EMPLOYES
   WHERE FONCTION LIKE 'Rep%' AND PAYS = 'France';
   while v_compteur < SQL%ROWCOUNT     
   loop
      v_compteur := v_compteur + 1;
      dbms_output.put_line( t_emp(v_compteur).NO_EMPLOYE||' '||
         t_emp(v_compteur).NOM||' '||t_emp(v_compteur).PRENOM);
   end loop;
end;
/

--for
declare
   TYPE mon_type_tableau IS TABLE OF VARCHAR2(20)
        INDEX BY BINARY_INTEGER;
   mon_tableau mon_type_tableau;
begin
   for i in 1..3 
   loop 
       mon_tableau(i) := 'Ligne numéro : '||i;
   end loop;
       
   for v_compteur in reverse 1..3 loop 
       dbms_output.put_line( mon_tableau(v_compteur)); 
   end loop;
end;
/




