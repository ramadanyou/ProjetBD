
-- R1 : Donner les noms et prénoms des joueurs qui ont joué dans au moins 2 matchs et dont le budget de leur équipe dépasse 7000000.

select J.nomJ, J.prenomJ, count(S.codeM) as nbMatchsJoues
from Joueur J, Statistiques S, Equipe E
where E.budgetE > 7000000
  and J.codeJ = S.codeJ
  and E.nomE = J.nomE
group by J.nomJ, J.prenomJ, J.codeJ
having count(S.codeM) >= 2;


--R2 : Afficher le classement des joueurs (prénom et numéro) qui ont marqué le plus de points à la fin de la saison régulière.

select J.nomJ, J.numeroJ, sum(S.nbPoints) as nbPointsMarques
from Joueur J, Statistiques S, Match M
where J.codeJ = S.codeJ
  and S.codeM = M.codeM
  and M.nomP = 'Saison régulière'
group by J.nomJ, J.numeroJ, J.codeJ
order by nbPointsMarques desc;

	
--R3 : Donner les noms des 4 premières équipes de la conférence ouest qui se sont qualifiées pour les playoffs. Vous ordonnerz le résultat par rang.

select Cl.rang, Cl.nomE
from Classement Cl, Conference C
where Cl.nomP = 'Saison régulière'
  and Cl.rang <= 4
  and Cl.codeC = C.codeC
  and C.nomC = 'Conférence Ouest'
order by Cl.rang;


-- R4 : Quel est le nom de l'équipe gagnante des playoffs de chaque conférence ?

select Cl.nomE, C.nomC
from Classement Cl, Conference C
where Cl.nomP = 'Playoffs'
  and Cl.codeC = C.codeC;


-- R5 : Donner le nom de l'entraîneur, le nom et la date de création de la division, la dernière année de victoire de la conférence pour l'équipe gagnante des finales dont vous mentionnerez le nom. 

select E.nomE, E.nomEntraineur, D.nomD, D.dateCreationD, C.derAnneeVic
from Classement Cl, Equipe E, Division D, Conference C
where Cl.nomP = 'Finales'
  and Cl.nomE = E.nomE
  and E.codeD = D.codeD
  and D.codeC = C.codeC;
  


