CREATE SEQUENCE S_CAT START WITH 11;


declare
  v_code CATEGORIES.CODE_CATEGORIE%TYPE := S_CAT.NEXTVAL;
  v_catg CATEGORIES.NOM_CATEGORIE%TYPE
             := 'Fruits et légumes frais';
  v_desc CATEGORIES.DESCRIPTION%TYPE
             := 'Fruits et légumes frais';
  ve_cat CATEGORIES%ROWTYPE;
  v_ret  NUMBER(2);
begin
  SELECT COUNT(*) INTO v_ret FROM CATEGORIES
  WHERE CODE_CATEGORIE = v_code;
  dbms_output.put_line('Le nombre d''enregistrements est : '
                        ||v_ret);
  INSERT INTO CATEGORIES VALUES ( v_code, v_catg, v_desc);
  SELECT * INTO ve_cat FROM CATEGORIES
  WHERE CODE_CATEGORIE = v_code;
  dbms_output.put_line(ve_cat.CODE_CATEGORIE||'--'||
      ve_cat.NOM_CATEGORIE||'--'||ve_cat.DESCRIPTION);
end;
/



declare
     v_client CLIENTS%ROWTYPE;
begin
     v_client.CODE_CLIENT := 'ETELI';
     v_client.SOCIETE     := 'ETELIA';
     v_client.ADRESSE     := '44, Paul Claudel';
     v_client.VILLE       := 'STRASBOURG';
     v_client.CODE_POSTAL := '67000';
     v_client.PAYS        := 'FRANCE';
     v_client.TELEPHONE   := '03.88.27.13.35';
     INSERT INTO CLIENTS VALUES v_client;
end;
/


SELECT CODE_CLIENT, SOCIETE, ADRESSE,
       VILLE, CODE_POSTAL, PAYS, TELEPHONE
FROM CLIENTS
WHERE CODE_CLIENT = 'ETELI';


