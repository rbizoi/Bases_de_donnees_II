set serveroutput on
var v_li varchar2(20)

declare  
    v_pl varchar(20) := 'Tintin';   
    v_utl varchar(20);   
    v_subst varchar(20) := &variable;
begin
    :v_li := v_pl;
	v_utl := user;
	dbms_output.put_line('v_pl    = '||v_pl);
	dbms_output.put_line('v_li    = '||:v_li);
	dbms_output.put_line('v_subst = '||v_subst);
	dbms_output.put_line('v_utl   = '||v_utl );
end;
/