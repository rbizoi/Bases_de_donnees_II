set serveroutput on

declare
   TYPE adresse IS RECORD (  ADRESSE     VARCHAR2(60)
                              := '44, rue Paul Claudel',
                             VILLE       VARCHAR2(15)
                              := 'STRASBOURG',
                             CODE_POSTAL VARCHAR2(10)
                              := '67000');
   mon_adresse  adresse;
   autre_adresse  adresse;
begin
   dbms_output.put_line( mon_adresse.ADRESSE      ||' '||
                         mon_adresse.CODE_POSTAL  ||' '||
                         mon_adresse.VILLE        );
   mon_adresse.ADRESSE      := '104, rue Mélanie';
   mon_adresse.VILLE        := 'STRASBOURG';
   mon_adresse.CODE_POSTAL  := '67200';
   autre_adresse            :=   mon_adresse;
   dbms_output.put_line( autre_adresse.ADRESSE      ||' '||
                         autre_adresse.CODE_POSTAL  ||' '||
                         autre_adresse.VILLE        );
end;
/

declare
   TYPE adresse IS RECORD (  ADRESSE     VARCHAR2(60),
                             VILLE       VARCHAR2(15),
                             CODE_POSTAL VARCHAR2(10));
   TYPE employe IS RECORD (  NOM         VARCHAR2(20),
                             PRENOM      VARCHAR2(10),
                             adr_emp     adresse     );
   mon_employe  employe;
begin
   mon_employe.NOM                  := 'FABER';
   mon_employe.PRENOM               := 'Pierre';
   mon_employe.adr_emp.ADRESSE      := '44, rue Paul Claudel';
   mon_employe.adr_emp.VILLE        := 'STRASBOURG';
   mon_employe.adr_emp.CODE_POSTAL  := '67000';
   dbms_output.put_line( mon_employe.NOM                ||' '||
                         mon_employe.PRENOM             ||' '||
                         mon_employe.adr_emp.ADRESSE    ||' '||
                         mon_employe.adr_emp.CODE_POSTAL||' '||
                         mon_employe.adr_emp.VILLE        );
end;
/


/*Les tableaux */
declare
    TYPE EMPLOYE IS RECORD ( NOM         VARCHAR2(30),
                             PRENOM      VARCHAR2(30));
    TYPE TABLEAU_EMPLOYES IS TABLE OF EMPLOYE;
    T_EMPLOYES TABLEAU_EMPLOYES ;
    R_EMPLOYE EMPLOYE; P_EMPLOYE EMPLOYE; I_EMPLOYE EMPLOYE;
begin
   R_EMPLOYE.NOM := 'BIZOÏ'; R_EMPLOYE.PRENOM := 'Razvan';
   P_EMPLOYE.NOM := 'FABER'; P_EMPLOYE.PRENOM := 'Pierre';
   I_EMPLOYE.NOM := 'DULUC'; I_EMPLOYE.PRENOM := 'Isabelle';
   T_EMPLOYES:=TABLEAU_EMPLOYES(R_EMPLOYE,P_EMPLOYE,I_EMPLOYE);
   dbms_output.put_line( T_EMPLOYES(1).NOM||' '||
                          T_EMPLOYES(1).PRENOM);
   dbms_output.put_line( T_EMPLOYES(2).NOM||' '||
                          T_EMPLOYES(2).PRENOM);
   dbms_output.put_line( T_EMPLOYES(3).NOM||' '||
                          T_EMPLOYES(3).PRENOM);
end;
/
