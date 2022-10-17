set serveroutput on size 5000

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




declare
    nom_varA           NUMBER(8) DEFAULT 10 ;
    a$nom_varG         DATE         := '01/07/2011';
    nom_varI           NUMBER(3)    := 123.45678;
    nom_varK  CONSTANT NUMBER(12,3) := 1234.5678;
begin
    dbms_output.put_line( 'nom_varA   :'||nom_varA  );
    dbms_output.put_line( 'a$nom_varG :'||a$nom_varG);
    dbms_output.put_line( 'nom_varI   :'||nom_varI  );
    dbms_output.put_line( 'nom_varK   :'||nom_varK  );
end;
/




