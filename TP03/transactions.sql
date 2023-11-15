-- session A
SELECT * FROM COMMANDES FOR UPDATE;

-- session B
UPDATE COMMANDES SET PORT=100 WHERE NO_COMMANDE=215319;
-- provoque une mise en attente de l'update

-- session A
COMMIT;
-- la transaction B peut continuer


-- session A
LOCK TABLE COMMANDES IN EXCLUSIVE MODE NOWAIT;

-- session B
INSERT INTO COMMANDES (NO_COMMANDE,CODE_CLIENT,NO_EMPLOYE,DATE_COMMANDE,DATE_ENVOI,PORT) 
	VALUES ('216814','ALFKI',2,'26/03/2023','08/05/2023',86.9);
-- l'insertion de B est mise en attente


    