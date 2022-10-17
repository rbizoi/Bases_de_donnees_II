VAR utilisateur varchar2(50)
declare
  utilisateur varchar2(50) := 'Bloc principal :'||USER;
begin
  :utilisateur := 'Variable de liaison :'||USER;
  declare
      utilisateur varchar2(50) := 'Premier Bloc imbriqué :'
                                  ||USER;
  begin
      declare
         utilisateur varchar2(50) := 'Deuxième Bloc imbriqué :'
                                       ||USER;
      begin
         dbms_output.put_line(  utilisateur);
         dbms_output.put_line( :utilisateur);
      end;
      dbms_output.put_line(  utilisateur);
  end;
  dbms_output.put_line(  utilisateur);
end;
/