	 
-- Création des tables

    -- Table 1 : Confrence(*codeC, nomC, derAnneeVic)

create table Conference(
    codeC varchar (2),
    nomC varchar (20),
    derAnneeVic number,
    constraint pk_Conference primary key (codeC)
);

    -- Table 2 : Division(*codeD, nomD, dateCreation, #codeC)

create table Division(
    codeD varchar (4),
    nomD varchar (20),
    dateCreationD number,
    codeC varchar (4) not null,
    constraint pk_Division primary key (codeD),
    constraint fk_Division_Conference foreign key (codeC) references Conference
);

    -- Table 3 : Equipe(*nomE, budgetE, nomEntraineur, #codeD)

create table Equipe(
    nomE varchar(40),
    budgetE number,
    nomEntraineur varchar(30),
    codeD varchar(4) not null,
    constraint pk_Equipe primary key (nomE),
    constraint fk_Equipe_Division foreign key (codeD) references Division,
    constraint ck_Equipe_budgetE check (budgetE > 0)
);

    -- Table 4 : Joueur(*codeJ, nomJ, prenomJ, dateNaisJ, tailleJ, numeroJ, #nomE)

create table Joueur(
    codeJ varchar(4),
    nomJ varchar(20),
    prenomJ varchar(20),
    dateNaisJ date,
    tailleJ number,
    numeroJ number,
    nomE varchar(40),
    constraint pk_Joueur primary key (codeJ),
    constraint fk_Joueur_Equipe foreign key (nomE) references Equipe,
    constraint ck_Joueur_numeroJ check (numeroJ >= 0)
);

    -- Table 5 : Phase(*nomP)

create table Phase(
    nomP varchar(20),
    constraint pk_Phase primary key (nomP),
    constraint ck_Phase_nomP check (nomP = 'Saison régulière' or nomP = 'Playoffs' or nomP = 'Finales')
);

 -- Table 6 : Match(*codeM, dateM, lieuM, *nomP)

create table Match(
    codeM varchar(6),
    dateM date,
    lieuM varchar(40),
    nomP varchar(20),
    constraint pk_Match primary key (codeM),
    constraint fk_Match_Phase foreign key (nomP) references Phase
);

    -- Table 7 : ScoreEquipeMatch(*#nomE, *#codeM, statut, score)

create table ScoreEquipeMatch(
    nomE varchar(40),
    codeM varchar(6),
    statut varchar(20),
    score number,
    constraint pk_ScoreEquipeMatch primary key (nomE, codeM),
    constraint fk_ScoreEquipeMatch_Equipe foreign key (nomE) references Equipe,
    constraint fk_ScoreEquipeMatch_Match foreign key (codeM) references Match,
    constraint ck_ScoreEquipeMatch_statut check (statut ='Domicile' or statut ='Extérieur'),
     constraint ck_ScoreEquipeMatch_score check (score >=0 )
);

    -- Table 8 : Statistiques(*#codeJ, *#codeM, tempsJeu, nbPoints, nbRebonds, nbPasses, nbContres, pourcentR3, pourcentR2, pourcentL)

create table Statistiques(
    codeJ varchar(4),
    codeM varchar(6),
    tempsJeu number,
    nbPoints number,
    nbRebonds number,
    nbPasses number,
    nbContres number,
    pourcentR3 number,
    pourcentR2 number,
    pourcentL number,
    constraint pk_Statistiques primary key (codeJ, codeM),
    constraint fk_Statistiques_Joueur foreign key (codeJ) references Joueur,
    constraint fk_Statistiques_Match foreign key (codeM) references Match
);

    -- Table 9 : Classement(*#codeC, *#nomE, *#nomP, rang)

create table Classement(
    codeC varchar(2),
    nomE varchar(40),
    nomP varchar(20),
    rang number,
    constraint pk_Classement primary key (codeC, nomE, nomP),
    constraint fk_Classement_Conference foreign key (codeC) references Conference,
    constraint fk_Classement_Equipe foreign key (nomE) references Equipe,
    constraint fk_Classement_Phase foreign key (nomP) references Phase
);




-- Insertion des données

-- Conference

insert into Conference(codeC, nomC, derAnneeVic)
    values('CE', 'Conférence Est', 2020);
insert into Conference 
    values('CO', 'Conférence Ouest', 2021);

-- Division

insert into Division(codeD, nomD, dateCreationD, codeC)
    values('D01', 'Nord-Ouest', 1987, 'CO');
insert into Division
    values('D02', 'Pacifique', 1986, 'CO');
insert into Division
    values('D03', 'Sud-Ouest', 1904, 'CO');
insert into Division
    values('D04', 'Atlantique', 1946, 'CE');
insert into Division
    values('D05', 'Centrale', 2005, 'CE');
insert into Division
    values('D06', 'Sud-Est', 2003, 'CE');

-- Equipe

    -- Nord-Ouest
insert into Equipe(nomE, budgetE, nomEntraineur, codeD)
    values('Nuggets de Denver', 8000000, 'Michael Malone', 'D01');
insert into Equipe values('Timberwolves du Minnesota', 5500000, 'Chris Finch', 'D01');
insert into Equipe values('Thunder d''Oklahoma City', 5000000, 'Mark Daigneault', 'D01');
insert into Equipe values('Trail Blazers de Portland', 7000000, 'Terry Stotts', 'D01');
insert into Equipe values('Utah Jazz', 8500000, 'Quin Snyder', 'D01');

    -- Pacifique
insert into Equipe values('Warriors de Golden State', 9000000, 'Steve Kerr', 'D02');
insert into Equipe values('Clippers de Los Angeles', 8000000, 'Tyronn Lue', 'D02');
insert into Equipe values('Lakers de Los Angeles', 8500000, 'Frank Vogel', 'D02');
insert into Equipe values('Suns de Phoenix', 7500000, 'Monty Williams', 'D02');
insert into Equipe values('Kings de Sacramento', 6000000, 'Luke Walton', 'D02');

    -- Sud-Ouest
insert into Equipe values('Mavericks de Dallas', 8000000, 'Rick Carlisle', 'D03');
insert into Equipe values('Rockets de Houston', 6000000, 'Stephen Silas', 'D03');
insert into Equipe values('Grizzlies de Memphis', 7000000, 'Taylor Jenkins', 'D03');
insert into Equipe values('Pelicans de La Nouvelle-Orléans', 6500000, 'Stan Van Gundy', 'D03');
insert into Equipe values('Spurs de San Antonio', 7500000, 'Gregg Popovich', 'D03');

    -- Atlantique
insert into Equipe values('Celtics de Boston', 9000000, 'Brad Stevens', 'D04');
insert into Equipe values('Nets de Brooklyn', 7500000, 'Steve Nash', 'D04');
insert into Equipe values('Knicks de New York', 7000000, 'Tom Thibodeau', 'D04');
insert into Equipe values('76ers de Philadelphie', 8000000, 'Doc Rivers', 'D04');
insert into Equipe values('Raptors de Toronto', 8500000, 'Nick Nurse', 'D04');

    -- Centrale
insert into Equipe values('Bulls de Chicago', 6500000, 'Billy Donovan', 'D05');
insert into Equipe values('Cavaliers de Cleveland', 6000000, 'J.B. Bickerstaff', 'D05');
insert into Equipe values('Pistons de Détroit', 5500000, 'Dwane Casey', 'D05');
insert into Equipe values('Pacers de l''Indiana', 7000000, 'Nate Bjorkgren', 'D05');
insert into Equipe values('Bucks de Milwaukee', 8500000, 'Mike Budenholzer', 'D05');

    -- Sud-Est
insert into Equipe values('Hawks d''Atlanta', 6500000, 'Nate McMillan', 'D06');
insert into Equipe values('Hornets de Charlotte', 6000000, 'James Borrego', 'D06');
insert into Equipe values('Heat de Miami', 7500000, 'Erik Spoelstra', 'D06');
insert into Equipe values('Magic d''Orlando', 5500000, 'Steve Clifford', 'D06');
insert into Equipe values('Wizards de Washington', 7000000, 'Scott Brooks', 'D06');

-- Joueur 

insert into Joueur(codeJ, nomJ, prenomJ, dateNaisJ, tailleJ, numeroJ, nomE)
values('J001', 'James', 'LeBron', '30/12/1984', 203, 23, 'Warriors de Golden State');
insert into Joueur values('J002', 'Davis', 'Anthony', '11/03/1993', 208, 3, 'Grizzlies de Memphis');
insert into Joueur values('J003', 'Curry', 'Stephen', '14/03/1988', 191, 30, 'Grizzlies de Memphis');
insert into Joueur values('J004', 'Durant', 'Kevin', '29/09/1988', 208, 7, 'Lakers de Los Angeles');
insert into Joueur values('J005', 'Harden', 'James', '26/08/1989', 196, 13, 'Suns de Phoenix');
insert into Joueur values('J006', 'Antetokounmpo', 'Giannis', '06/12/1994', 211, 34, 'Nets de Brooklyn');
insert into Joueur values('J007', 'Embiid', 'Joel', '16/03/1994', 213, 21, 'Bucks de Milwaukee');
insert into Joueur values('J008', 'Simmons', 'Ben', '20/07/1996', 211, 25, '76ers de Philadelphie');
insert into Joueur values('J009', 'Doncic', 'Luka', '28/02/1999', 201, 77, 'Celtics de Boston');

-- Phase

insert into Phase(nomP)
    values('Saison régulière');
insert into Phase values('Playoffs');
insert into Phase values('Finales');
 


-- Matchs et ScoreEquipeMatch

    -- Saison régulière
insert into Match(codeM, dateM, lieuM, nomP)
    values('SR_001', '01/01/2022', 'Stade de Suns', 'Saison régulière');
insert into ScoreEquipeMatch(nomE, codeM, statut, score)
    values('Suns de Phoenix', 'SR_001', 'Domicile', 80);
insert into ScoreEquipeMatch(nomE, codeM, statut, score)
    values('Grizzlies de Memphis', 'SR_001', 'Extérieur', 110);

insert into Match(codeM, dateM, lieuM, nomP)
    values('SR_137', '15/03/2022', 'Stade de Grizzlies', 'Saison régulière');
insert into ScoreEquipeMatch(nomE, codeM, statut, score)
    values('Grizzlies de Memphis', 'SR_137', 'Domicile', 125);
insert into ScoreEquipeMatch(nomE, codeM, statut, score)
    values('Suns de Phoenix', 'SR_137', 'Extérieur', 100);

insert into Match(codeM, dateM, lieuM, nomP)
    values('SR_322', '01/04/2022', 'Stade de Warriors', 'Saison régulière');
insert into ScoreEquipeMatch(nomE, codeM, statut, score)
    values('Warriors de Golden State', 'SR_322', 'Domicile', 120);
insert into ScoreEquipeMatch(nomE, codeM, statut, score)
    values('Lakers de Los Angeles', 'SR_322', 'Extérieur', 95);

insert into Match(codeM, dateM, lieuM, nomP)
    values('SR_058', '09/02/2022', 'Stade de Nets', 'Saison régulière');
insert into ScoreEquipeMatch(nomE, codeM, statut, score)
    values('76ers de Philadelphie', 'SR_058', 'Domicile', 104);
insert into ScoreEquipeMatch(nomE, codeM, statut, score)
    values('Nets de Brooklyn', 'SR_058', 'Extérieur', 110);

insert into Match(codeM, dateM, lieuM, nomP)
    values('SR_456', '19/05/2022', 'Stade de Celtics', 'Saison régulière');
insert into ScoreEquipeMatch(nomE, codeM, statut, score)
    values('Celtics de Boston', 'SR_456', 'Domicile', 95);
insert into ScoreEquipeMatch(nomE, codeM, statut, score)
    values('Bucks de Milwaukee', 'SR_456', 'Extérieur', 93);


    -- Playoffs
insert into Match(codeM, dateM, lieuM, nomP)
    values('PO_001', '21/12/2022', 'Stade de Warriors', 'Playoffs');
insert into ScoreEquipeMatch(nomE, codeM, statut, score)
    values('Warriors de Golden State', 'PO_001', 'Domicile', 140);
insert into ScoreEquipeMatch(nomE, codeM, statut, score)
    values('Suns de Phoenix', 'PO_001', 'Extérieur', 128);

insert into Match(codeM, dateM, lieuM, nomP)
    values('PO_002', '28/12/2022', 'Stade de Nets', 'Playoffs');
insert into ScoreEquipeMatch(nomE, codeM, statut, score)
    values('Nets de Brooklyn', 'PO_002', 'Domicile', 135);
insert into ScoreEquipeMatch(nomE, codeM, statut, score)
    values('Bucks de Milwaukee', 'PO_002', 'Extérieur', 130);

    -- Finales
insert into Match(codeM, dateM, lieuM, nomP)
    values('Fl_001', '31/12/2022', 'Stade de Warriors', 'Finales');
insert into ScoreEquipeMatch(nomE, codeM, statut, score)
    values('Warriors de Golden State', 'Fl_001', 'Domicile', 150);
insert into ScoreEquipeMatch(nomE, codeM, statut, score)
    values('Nets de Brooklyn', 'Fl_001', 'Extérieur', 148);



-- Statistiques des joueurs de la saison régulière dans la conférence Ouest

insert into Statistiques(codeJ, codeM, tempsJeu, nbPoints, nbRebonds, nbPasses, nbContres, pourcentR3, pourcentR2, pourcentL)
    values('J005', 'SR_001', 48, 80, 5, 5, 2, NULL, NULL, NULL);
insert into Statistiques values('J002', 'SR_001', 30, 70, 15, 5, 1, NULL, NULL, NULL);
insert into Statistiques values('J003', 'SR_001', 18, 40, 5, 5, 2, NULL, NULL, NULL);

insert into Statistiques values('J002', 'SR_137', 28, 90, 5, 5, 2, NULL, NULL, NULL);
insert into Statistiques values('J003', 'SR_137', 20, 35, 15, 5, 1, NULL, NULL, NULL);
insert into Statistiques values('J005', 'SR_137', 48, 100, 5, 5, 2, NULL, NULL, NULL);

insert into Statistiques values('J001', 'SR_322', 48, 120, 5, 5, 2, NULL, NULL, NULL);
insert into Statistiques values('J004', 'SR_322', 48, 95, 15, 5, 1, NULL, NULL, NULL);


-- Classement

    -- Saison régulière
insert into Classement(codeC, nomE, nomP, rang)
    values('CO', 'Warriors de Golden State', 'Saison régulière', 1);
insert into Classement values('CO', 'Grizzlies de Memphis', 'Saison régulière', 2);
insert into Classement values('CO', 'Lakers de Los Angeles', 'Saison régulière', 3);
insert into Classement values('CO', 'Suns de Phoenix', 'Saison régulière', 4);

insert into Classement values('CE', 'Nets de Brooklyn', 'Saison régulière', 1);
insert into Classement values('CE', 'Bucks de Milwaukee', 'Saison régulière', 2);
insert into Classement values('CE', '76ers de Philadelphie', 'Saison régulière', 3);
insert into Classement values('CE', 'Celtics de Boston', 'Saison régulière', 4);

    -- Playoffs
insert into Classement values('CO', 'Warriors de Golden State', 'Playoffs', NULL);

insert into Classement values('CE', 'Nets de Brooklyn', 'Playoffs', NULL);

    -- Finales
insert into Classement values('CO', 'Warriors de Golden State', 'Finales', NULL);


