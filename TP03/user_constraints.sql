SELECT UC_R.TABLE_NAME,
       UCC_R.COLUMN_NAME,
       UC_R.CONSTRAINT_TYPE,
       DECODE(UC_R.CONSTRAINT_TYPE,'P','PK-Clé Primaire',
                                   'R', 'FK-Clé Étrangère',
                                   'C','CHECK', 
                                   'U', 'Clé Unique', 'autre') TYPE,
       UC_R.SEARCH_CONDITION,
       UC_R.DEFERRABLE,
       UC_R.DEFERRED 
FROM USER_CONSTRAINTS UC_R
     JOIN USER_CONS_COLUMNS UCC_R
        ON UCC_R.CONSTRAINT_NAME = UC_R.CONSTRAINT_NAME
ORDER BY UC_R.TABLE_NAME, TYPE DESC, UCC_R.POSITION;
