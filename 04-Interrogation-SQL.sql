

declare
   v_employe EMPLOYES%ROWTYPE;
begin
   SELECT * INTO v_employe FROM EMPLOYES WHERE NO_EMPLOYE = 5;
   dbms_output.put_line( v_employe.NOM ||' '|| v_employe.SALAIRE
                         ||' '|| v_employe.COMMISSION  );
                         
   v_employe.SALAIRE    := v_employe.SALAIRE * 1.1;                          
   v_employe.COMMISSION := 1000;
   
   UPDATE EMPLOYES SET ROW = v_employe WHERE NO_EMPLOYE = 5;
   SELECT * INTO v_employe FROM EMPLOYES WHERE NO_EMPLOYE = 5;   
   dbms_output.put_line( v_employe.NOM ||' '|| v_employe.SALAIRE   
                         ||' '|| v_employe.COMMISSION  );
end;                         
/


/*aucune donnée trouvée*/
declare
  v_employe EMPLOYES%ROWTYPE;
begin 
  SELECT * INTO v_employe FROM EMPLOYES WHERE NO_EMPLOYE = 150;
end;
/




declare
   v_employe EMPLOYES%ROWTYPE;
begin
   SELECT * INTO v_employe FROM EMPLOYES WHERE ROWNUM < 5;
end;   
/


declare
     TYPE EMPLOYE IS  TABLE OF EMPLOYES%ROWTYPE;
     TYPE TABLEAU_NOM IS TABLE OF EMPLOYES.NOM%TYPE
                  INDEX BY BINARY_INTEGER;
     TYPE TABLEAU_PRENOM IS TABLE OF EMPLOYES.PRENOM%TYPE
                  INDEX BY BINARY_INTEGER;
     T_NOM        TABLEAU_NOM;
     T_PRENOM     TABLEAU_PRENOM;
begin

   SELECT NOM, PRENOM
   BULK COLLECT INTO T_NOM, T_PRENOM
   FROM EMPLOYES
   WHERE ROWNUM < 5;
   
   for i in 1..4 loop
       dbms_output.put_line(T_NOM(i)||' '||T_PRENOM(i));
   end loop;
end;
/

/*BULK COLLECT*/

declare  
	v_emp employes%rowtype;   
	type t_emp is table of employes%rowtype index by pls_integer;
	v_t_emp t_emp; 
	i int := 1;
begin
	select * bulk collect into v_t_emp from employes ;
	for i in v_t_emp.first..v_t_emp.LAST loop 
			dbms_output.put_line(i||' NOM = '|| v_t_emp(i).NOM
	  ||' PRENOM = '||v_t_emp(i).PRENOM );
	   end loop;
end;
/


declare  
	v_emp employes%rowtype;   
	type t_emp is table of employes%rowtype index by pls_integer;
	v_t_emp t_emp; 
	i int := 1;
begin
	select * bulk collect into v_t_emp from employes ;
    i:= v_t_emp.first;
	loop
	  dbms_output.put_line(i||' NOM = '|| v_t_emp(i).NOM
	                   ||' PRENOM = '||v_t_emp(i).PRENOM );
      i := v_t_emp.next(i);
      exit when i is null;	  
	end loop;
end;
/



declare  
	v_emp employes%rowtype;   
	type t_emp is table of employes%rowtype index by pls_integer;
	v_t_emp t_emp; 
	i int := 1;
begin
	select * bulk collect into v_t_emp 
	from employes 
	where no_employe like 'R%';
    i:= v_t_emp.first;
	loop
	  dbms_output.put_line(i||' NOM = '|| v_t_emp(i).NOM
	                   ||' PRENOM = '||v_t_emp(i).PRENOM );
      i := v_t_emp.next(i);
      exit when i is null;	  
	end loop;
end;
/



