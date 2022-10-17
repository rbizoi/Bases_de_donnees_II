set serveroutput on
/*
  Commentaire muti-lignes
  suite commentaire 
*/

-- Commentaire mono-ligne

var v_li varchar2(20)
ACCEPT variable_subst CHAR DEF 'Bonjour' PROMPT 'Variable substitution ?';

declare  
    v_pl    varchar(20) := 'Tintin';   
    v_date  date        := sysdate;
    v_subst varchar(20) := '&variable_subst';
    v_utl   varchar(20);   
    v_uid   number      := uid;   
begin
    :v_li := v_pl;
	v_utl := user;
	dbms_output.put_line('v_pl    = '||v_pl   );
	dbms_output.put_line('v_li    = '||:v_li  );
	dbms_output.put_line('v_subst = '||v_subst);
	dbms_output.put_line('v_utl   = '||v_utl  );
    dbms_output.put_line('v_date  = '||v_date );
    dbms_output.put_line('v_uid   = '||v_uid  );
end;
/
