
-- Requête 1
Select E.nomE, J.numeroJ, J.nomJ, S.tempsJeu, S.nbPoints
From Equipe E, Joueur J, Statistiques S, Match  M, ScoreEquipeMatch SEM
Where E.nomE = J.nomE 
  and J.codeJ = S.codeJ 
  and S.codeM = M.codeM 
  and E.nomE = SEM.nomE 
  and SEM.codeM = M.codeM 
  and M.codeM = 'SR_322'
order by E.nomE, J.numeroJ;



-- Requête 2

select distinct E.nomE, D.nomD, C.nomC
from Equipe E, Division D, Conference C, ScoreEquipeMatch SEM
where SEM.statut = 'Extérieur'
  and SEM.nomE = E.nomE
  and E.codeD = D.codeD
  and D.codeC = C.codeC
  and E.nomE not in (select distinct E.nomE
		     from Equipe E, Match M, ScoreEquipeMatch SEM
  		     where E.nomE = SEM.nomE 
    		     and M.codeM = SEM.codeM
    		     and SEM.statut = 'Extérieur'
    		     and SEM.score > (select score
  				      from ScoreEquipeMatch
				      where statut = 'Domicile' 
				      and codeM = M.codeM
		    		     )
   		   );

-- Requête 3

select E.*
from Equipe E, Division D, Conference C
where C.codeC = 'CO'
  and C.codeC = D.codeC
  and D.codeD = E.codeD;


-- Requête 4

select J.codeJ, J.nomJ, J.prenomJ, J.dateNaisJ, J.tailleJ, J.numeroJ, count(S.codeM) as nbMatchsJoues, sum(S.nbPoints) as nbPointsMarques, avg(S.nbRebonds) as nbMoyenRebonds, avg(S.nbPasses) as nbMoyenInterceptions, avg(S.nbContres) as nbMoyenContres
from Joueur J, Statistiques S, Equipe E, Match M
where J.codeJ = S.codeJ
  and J.nomE = E.nomE
  and S.codeM = M.codeM
  and E.nomE = 'Grizzlies de Memphis'
  and M.nomP = 'Saison régulière'
group by J.codeJ, J.nomJ, J.prenomJ, J.dateNaisJ, J.tailleJ, J.numeroJ;


-- Requête 5

select M.dateM, M.lieuM, E1.nomE as equipeRecevant, SEM1.score as scoreRecevant, E2.nomE as equipeDeplaçant, SEM2.score as scoreDeplaçant
from Match M, Equipe E1, Equipe E2, ScoreEquipeMatch SEM1, ScoreEquipeMatch SEM2
where M.codeM = SEM1.codeM
  and M.codeM = SEM2.codeM
  and SEM1.nomE = E1.nomE
  and SEM2.nomE = E2.nomE
  and SEM1.statut = 'Domicile'
  and SEM2.statut = 'Extérieur'
  and M.dateM between '20/12/2022' and '31/12/2022';



