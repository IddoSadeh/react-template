-- init.sql
CREATE ROLE Soccer_Scout WITH LOGIN PASSWORD '${POSTGRES_PASSWORD}';


-- InjuryTypeInfo
CREATE TABLE IF NOT EXISTS InjuryTypeInfo (
    injury_type VARCHAR(255) PRIMARY KEY,
    recovery_time VARCHAR(255)
);
-- ClubIdentity
CREATE TABLE IF NOT EXISTS ClubIdentity (
    ClubName VARCHAR(255) PRIMARY KEY,
    Nickname VARCHAR(255),
    Team_color VARCHAR(255)
);
-- ClubMainInfo
CREATE TABLE IF NOT EXISTS ClubMainInfo (
    ClubOwner VARCHAR(255),
    Founded DATE,
    Website VARCHAR(255),
    City VARCHAR(255),
    Club_ID VARCHAR(255) PRIMARY KEY,
    ClubName VARCHAR(255),
    FOREIGN KEY (ClubName) REFERENCES ClubIdentity(ClubName)
);

-- League
CREATE TABLE IF NOT EXISTS League (
    ID VARCHAR(255) PRIMARY KEY,
    Country VARCHAR(255),
    LeagueName VARCHAR(255),
    Num_teams INTEGER,
    Num_relegations INTEGER,
    Num_promotions INTEGER,
    Num_continental_competition_spots INTEGER,
    Domestic_Cups_rules VARCHAR(255),
    International_Cups_rules VARCHAR(255),
    Confederation VARCHAR(255),
    Founded DATE,
    Organizing_body VARCHAR(255),
    Current_Champion VARCHAR(255),
    Most_Championships VARCHAR(255),
    TV_partners VARCHAR(255),
    Website VARCHAR(255),
    Level_on_Pyramid INTEGER,
    Relegation_to VARCHAR(255),
    Promotion_to VARCHAR(255)
);

-- Season
CREATE TABLE IF NOT EXISTS Season (
    SeasonYear VARCHAR(255),
    League_ID VARCHAR(255) NOT NULL,
    Champions VARCHAR(255),
    Relegated VARCHAR(255),
    Standings VARCHAR(255),
    Matches INTEGER,
    Teams INTEGER,
    Goals_Scored INTEGER,
    Top_Goalscorer VARCHAR(255),
    Best_Goalkeeper VARCHAR(255),
    Biggest_home_win INTEGER,
    Biggest_away_win INTEGER,
    Highest_scoring_game INTEGER,
    Longest_winning_run INTEGER,
    Longest_unbeaten_run INTEGER,
    Longest_winless_run INTEGER,
    Longest_losing_run INTEGER,
    Highest_attendance INTEGER,
    Lowest_attendance INTEGER,
    Total_attendance INTEGER,
    Average_attendance INTEGER,
    PRIMARY KEY(SeasonYear,League_ID),
    FOREIGN KEY (League_ID) REFERENCES League(ID)
);
-- Staff
CREATE TABLE IF NOT EXISTS Staff (
    ID VARCHAR(255) PRIMARY KEY,
    First_name VARCHAR(255),
    Last_name VARCHAR(255),
    Age INTEGER,
    Club_ID VARCHAR(255),
    Position VARCHAR(255),
    Nationality VARCHAR(255),
    Playing_career_position VARCHAR(255),
    Past_clubs VARCHAR(255),
    ContractDate DATE,
    FOREIGN KEY (Club_ID) REFERENCES ClubMainInfo(Club_ID)
);
-- PlayerBirthInfo
CREATE TABLE IF NOT EXISTS PlayerBirthInfo (
    birthdate DATE PRIMARY KEY,
    age INTEGER
);
-- Team
CREATE TABLE IF NOT EXISTS Team (
    Club_ID VARCHAR(255),
    Age_group VARCHAR(255),
    Coach_Manager VARCHAR(255) NOT NULL,
    League_ID VARCHAR(255),
    PRIMARY KEY (Club_ID, Age_group),
    FOREIGN KEY (Club_ID) REFERENCES ClubMainInfo(Club_ID),
    FOREIGN KEY (League_ID) REFERENCES League(ID)
);
-- PlayerGeneralInfo
CREATE TABLE IF NOT EXISTS PlayerGeneralInfo (
    ID VARCHAR(255) PRIMARY KEY,
    First_name VARCHAR(255),
    Last_name VARCHAR(255),
    PlayerNumber INTEGER,
    Age INTEGER,
    Height FLOAT,
    PlayerWeight FLOAT,
    Position VARCHAR(255),
    Active_foot VARCHAR(255),
    Nationality VARCHAR(255),
    AgentID VARCHAR(255),
    clubID VARCHAR(255),
    teamID VARCHAR(255),
    birthdate DATE,
    Age_group VARCHAR(255),
    FOREIGN KEY (birthdate) REFERENCES PlayerBirthInfo(birthdate),
    FOREIGN KEY (clubID) REFERENCES ClubMainInfo(Club_ID),
    FOREIGN KEY (AgentID) REFERENCES Staff(ID),
    FOREIGN KEY (clubID,Age_group) REFERENCES Team(Club_ID,Age_group)
);


-- Goalkeeper
CREATE TABLE IF NOT EXISTS Goalkeeper  (
    Player_ID VARCHAR(255)PRIMARY KEY,
    Throwing_arm VARCHAR(255),
    FOREIGN KEY (Player_ID) REFERENCES PlayerGeneralInfo(ID)
);

-- Stadium
CREATE TABLE IF NOT EXISTS Stadium (
    ID VARCHAR(255) PRIMARY KEY,
    Location VARCHAR(255),
    StadiumName VARCHAR(255),
    Seats_capacity INTEGER
);



-- Game
CREATE TABLE IF NOT EXISTS Game (
    Game_ID VARCHAR(255) UNIQUE,
    HomeClubID VARCHAR(255),
    AwayClubID VARCHAR(255),
    Age_group VARCHAR(255),
    Goals INTEGER,
    Stadium_ID VARCHAR(255),
    Competition VARCHAR(255),
    SeasonYear VARCHAR(255),
    Match_Date DATE,
    Odds FLOAT,
    Lineup VARCHAR(255),
    Substitutions VARCHAR(255),
    Yellow_cards INTEGER,
    Red_cards INTEGER,
    xG FLOAT,
    Ball_possession INTEGER,
    Goal_Attempts INTEGER,
    Shots_on_Goal INTEGER,
    Shots_off_Goal INTEGER,
    Blocked_Shots INTEGER,
    Corner_kicks INTEGER,
    Offsides INTEGER,
    Goalkeeper_saves INTEGER,
    Fouls INTEGER,
    Total_Passes INTEGER,
    Completed_Passes INTEGER,
    Tackles INTEGER,
    Attacks INTEGER,
    Dangerous_attacks INTEGER,
    League_ID VARCHAR(255),
    PRIMARY KEY (Game_ID, HomeClubID, AwayClubID),
    FOREIGN KEY (HomeClubID,Age_group) REFERENCES Team(Club_ID, Age_group),
    FOREIGN KEY (AwayClubID,Age_group) REFERENCES Team(Club_ID, Age_group),
    FOREIGN KEY (Stadium_ID) REFERENCES Stadium(ID),
    FOREIGN KEY (SeasonYear,League_ID) REFERENCES Season(SeasonYear,League_ID)
);

-- Statistics_Per_Game_Per_Player
CREATE TABLE IF NOT EXISTS Statistics_Per_Game_Per_Player (
    ID VARCHAR(255) PRIMARY KEY,
    Game_ID VARCHAR(255),
    Player_ID VARCHAR(255) NOT NULL,
    Minutes_played INTEGER,
    Assists INTEGER,
    Goals INTEGER,
    Shots_taken INTEGER,
    Shots_on_goal INTEGER,
    Shots_taken_inside_box INTEGER,
    Shots_taken_outside_box INTEGER,
    Passes_attempted INTEGER,
    Passes_complete INTEGER,
    Key_passes_attempted INTEGER,
    Key_passes_completed INTEGER,
    Crosses INTEGER,
    Aerial_challenges_attempted INTEGER,
    Aerial_challenges_success INTEGER,
    FOREIGN KEY (Player_ID) REFERENCES PlayerGeneralInfo(ID),
    FOREIGN KEY (Game_ID) REFERENCES Game(Game_ID)
);

-- Goalkeeper_Statistics
CREATE TABLE IF NOT EXISTS Goalkeeper_Statistics (
    Statistics_ID VARCHAR(255) PRIMARY KEY,
    Game_ID VARCHAR(255) NOT NULL,
    Clean_sheets INTEGER,
    Penalty_saved INTEGER,
    Penalties_faced INTEGER,
    Goals_conceded INTEGER,
    Mistakes INTEGER,
    Saves INTEGER,
    Shots_against INTEGER,
    FOREIGN KEY (Statistics_ID) REFERENCES Statistics_Per_Game_Per_Player(ID),
    FOREIGN KEY (Game_ID) REFERENCES Game(Game_ID)
);

-- PlayerInjuries
CREATE TABLE IF NOT EXISTS PlayerInjuries (
    injury_id VARCHAR(255),
    player_id VARCHAR(255) NOT NULL,
    injury_date DATE,
    injury_type VARCHAR(255),
    PRIMARY KEY (injury_id, player_id),
    FOREIGN KEY (player_id) REFERENCES PlayerGeneralInfo(ID),
    FOREIGN KEY (injury_type) REFERENCES InjuryTypeInfo(injury_type)
);



INSERT INTO InjuryTypeInfo (injury_type, recovery_time)
VALUES
    ('Sprained Ankle', '2 weeks'),
    ('Muscle Strain', '3 weeks'),
    ('Concussion', '1 week'),
    ('Fractured Bone', '6 weeks'),
    ('Torn Ligament', '8 weeks'),
    ('Dislocated Shoulder', '4 weeks'),
    ('Hamstring Injury', '3 weeks'),
    ('Knee Injury', '5 weeks'),
    ('Groin Strain', '2 weeks'),
    ('Calf Strain', '3 weeks');

INSERT INTO ClubIdentity (ClubName, Nickname, Team_color)
VALUES
    ('Manchester United', 'Red Devils', 'Red'),
    ('Real Madrid', 'Los Blancos', 'White'),
    ('FC Barcelona', 'Blaugrana', 'Blue and Red'),
    ('Bayern Munich', 'Die Bayern', 'Red and White'),
    ('Liverpool FC', 'The Reds', 'Red'),
    ('Juventus', 'La Vecchia Signora', 'Black and White'),
    ('Paris Saint-Germain', 'PSG', 'Blue and Red'),
    ('Manchester City', 'Citizens', 'Blue'),
    ('Chelsea FC', 'The Blues', 'Blue'),
    ('AC Milan', 'Rossoneri', 'Red and Black');
INSERT INTO ClubMainInfo (ClubOwner, Founded, Website, City, Club_ID, ClubName)
VALUES
    ('Joel Glazer', '1878-01-01', 'https://www.manutd.com', 'Manchester', 'MUFC', 'Manchester United'),
    ('Florentino Pérez', '1902-03-06', 'https://www.realmadrid.com', 'Madrid', 'RMCF', 'Real Madrid'),
    ('Josep Maria Bartomeu', '1899-11-29', 'https://www.fcbarcelona.com', 'Barcelona', 'FCB', 'FC Barcelona'),
    ('Herbert Hainer', '1900-02-27', 'https://fcbayern.com', 'Munich', 'FCBAY', 'Bayern Munich'),
    ('John W. Henry', '1892-06-03', 'https://www.liverpoolfc.com', 'Liverpool', 'LFC', 'Liverpool FC'),
    ('Andrea Agnelli', '1897-11-01', 'https://www.juventus.com', 'Turin', 'JUVE', 'Juventus'),
    ('Nasser Al-Khelaifi', '1970-08-12', 'https://en.psg.fr', 'Paris', 'PSG', 'Paris Saint-Germain'),
    ('Sheikh Mansour', '1880-04-16', 'https://www.mancity.com', 'Manchester', 'MCFC', 'Manchester City'),
    ('Roman Abramovich', '1905-03-10', 'https://www.chelseafc.com', 'London', 'CFC', 'Chelsea FC'),
    ('Paolo Scaroni', '1899-12-16', 'https://www.acmilan.com', 'Milan', 'ACM', 'AC Milan');

INSERT INTO League (ID, Country, LeagueName, Num_teams, Num_relegations, Num_promotions, Num_continental_competition_spots, Domestic_Cups_rules, International_Cups_rules, Confederation, Founded, Organizing_body, Current_Champion, Most_Championships, TV_partners, Website, Level_on_Pyramid, Relegation_to, Promotion_to)
VALUES
    ('EPL', 'England', 'Premier League', 20, 3, 3, 4, 'FA Cup, EFL Cup', 'UEFA Champions League, UEFA Europa League', 'UEFA', '1888-12-01', 'The FA', 'Manchester City', 'Manchester United', 'Sky Sports, BT Sport', 'https://www.premierleague.com', 1, NULL, NULL),
    ('LaLiga', 'Spain', 'La Liga', 20, 3, 3, 4, 'Copa del Rey', 'UEFA Champions League, UEFA Europa League', 'UEFA', '1929-02-28', 'RFEF', 'Atletico Madrid', 'Real Madrid', 'Movistar, DAZN', 'https://www.laliga.com', 1, NULL, NULL),
    ('SerieA', 'Italy', 'Serie A', 20, 3, 3, 4, 'Coppa Italia', 'UEFA Champions League, UEFA Europa League', 'UEFA', '1898-03-12', 'FIGC', 'Inter Milan', 'Juventus', 'Sky Italia', 'https://www.legaseriea.it', 1, NULL, NULL),
    ('Bundesliga', 'Germany', 'Bundesliga', 18, 2, 2, 4, 'DFB-Pokal', 'UEFA Champions League, UEFA Europa League', 'UEFA', '1963-08-24', 'DFL', 'Bayern Munich', 'Bayern Munich', 'Sky Deutschland', 'https://www.bundesliga.com', 1, NULL, NULL),
    ('Ligue1', 'France', 'Ligue 1', 20, 3, 3, 3, 'Coupe de France', 'UEFA Champions League, UEFA Europa League', 'UEFA', '1932-02-11', 'LFP', 'Lille', 'Saint-Étienne', 'Canal+, beIN Sports', 'https://www.ligue1.com', 1, NULL, NULL);


INSERT INTO Season (SeasonYear, League_ID, Champions, Relegated, Standings, Matches, Teams, Goals_Scored, Top_Goalscorer, Best_Goalkeeper, Biggest_home_win, Biggest_away_win, Highest_scoring_game, Longest_winning_run, Longest_unbeaten_run, Longest_winless_run, Longest_losing_run, Highest_attendance, Lowest_attendance, Total_attendance, Average_attendance)
VALUES
    ('2022-2023', 'EPL', 'Manchester City', 'Norwich City', 'https://example.com/epl/2022-2023/standings', 380, 20, 1025, 'Harry Kane (Tottenham Hotspur)', 'Ederson (Manchester City)', 6, 5, 8, 10, 18, 12, 8, 75000, 10000, 19993000, 52582),
    ('2022-2023', 'LaLiga', 'Atletico Madrid', 'Huesca, Real Mallorca, Espanyol', 'https://example.com/laliga/2022-2023/standings', 380, 20, 995, 'Lionel Messi (Paris Saint-Germain)', 'Jan Oblak (Atletico Madrid)', 7, 6, 9, 9, 17, 11, 10, 69000, 8000, 17134500, 45145),
    ('2022-2023', 'SerieA', 'Inter Milan', 'Spezia, Venezia, Empoli', 'https://example.com/seriea/2022-2023/standings', 380, 20, 1003, 'Cristiano Ronaldo (Juventus)', 'Samir Handanovic (Inter Milan)', 6, 7, 10, 8, 16, 13, 9, 78000, 12000, 18045500, 47487),
    ('2022-2023', 'Bundesliga', 'Bayern Munich', 'Bochum, Greuther Fürth', 'https://example.com/bundesliga/2022-2023/standings', 306, 18, 913, 'Robert Lewandowski (Bayern Munich)', 'Manuel Neuer (Bayern Munich)', 5, 4, 7, 12, 14, 10, 11, 80000, 15000, 15689000, 51264),
    ('2022-2023', 'Ligue1', 'Lille', 'Bordeaux, Clermont, Troyes', 'https://example.com/ligue1/2022-2023/standings', 380, 20, 979, 'Kylian Mbappé (Paris Saint-Germain)', 'Benjamin Lecomte (Montpellier)', 5, 4, 9, 11, 15, 12, 10, 67000, 7000, 17593000, 46292);

INSERT INTO Staff (ID, First_name, Last_name, Age, Club_ID, Position, Nationality, Playing_career_position, Past_clubs, ContractDate)
VALUES
    ('STAFF003', 'David', 'Williams', 38, 'MUFC', 'Fitness Coach', 'England', 'Midfielder', 'Man United U23', '2022-04-05'),
    ('STAFF004', 'Maria', 'Martinez', 42, 'RMCF', 'Physiotherapist', 'Spain', 'Defender', 'Real Madrid B', '2023-01-20'),
    ('STAFF005', 'Robert', 'Johnson', 50, 'FCBAY', 'Head Coach', 'Germany', 'Midfielder', 'Bayern Munich II', '2021-12-12'),
    ('STAFF006', 'Julia', 'Gomez', 35, 'LFC', 'Assistant Coach', 'England', 'Forward', 'Liverpool U23', '2023-05-10'),
    ('STAFF007', 'Paul', 'Smith', 48, 'FCB', 'Head Coach', 'France', 'Midfielder', 'Juventus, Marseille', '2020-11-18');

INSERT INTO PlayerBirthInfo (birthdate, age)
VALUES
    ('1997-10-30', 26),
    ('1996-05-18', 27),
    ('2000-02-12', 23),
    ('1994-12-07', 29),
    ('1999-08-25', 24);


INSERT INTO Team (Club_ID, Age_group, Coach_Manager, League_ID)
VALUES
    ('LFC', 'Senior', 'STAFF006', 'EPL'),
    ('LFC', 'Youth', 'STAFF008', 'LaLiga'),
    ('FCBAY', 'Senior', 'STAFF005', 'Bundesliga'),
    ('FCBAY', 'Youth', 'STAFF010', 'Bundesliga'),
    ('FCB', 'Senior', 'STAFF007', 'SerieA'),
    ('FCB', 'Youth', 'STAFF007', 'SerieA'),
    ('MUFC', 'Senior', 'STAFF0011', 'EPL'),
    ('MUFC', 'Youth', 'STAFF0011', 'EPL'),
    ('RMCF', 'Senior','STAFF0012','LaLiga'),
    ('RMCF', 'Youth','STAFF0012','LaLiga')
;

INSERT INTO PlayerGeneralInfo (ID, First_name, Last_name, PlayerNumber, Age, Height, PlayerWeight, Position, Active_foot, Nationality, AgentID, clubID, teamID, birthdate, Age_group)
VALUES
    ('PLAYER005', 'James', 'Brown', 9, 24, 182.0, 78.5, 'Forward', 'Left', 'England', 'STAFF003', 'MUFC', 'MUFC_Senior', '1997-10-30', 'Senior'),
    ('PLAYER006', 'Sophia', 'Garcia', 7, 23, 175.0, 68.0, 'Midfielder', 'Right', 'Spain', 'STAFF004', 'RMCF', 'RMCF_Senior', '1996-05-18', 'Senior'),
    ('PLAYER007', 'Daniel', 'Keller', 22, 21, 184.5, 80.0, 'Defender', 'Right', 'Germany', 'STAFF005', 'FCBAY', 'FCBAY_Senior', '2000-02-12', 'Senior'),
    ('PLAYER008', 'Isabella', 'Wong', 14, 27, 167.0, 65.0, 'Forward', 'Left', 'England', 'STAFF006', 'LFC', 'LFC_Senior', '1994-12-07', 'Senior'),
    ('PLAYER009', 'Thomas', 'Martin', 19, 22, 189.0, 83.5, 'Midfielder', 'Right', 'France', 'STAFF007', 'FCB', 'FCB_Senior', '1999-08-25', 'Senior');

INSERT INTO Goalkeeper (Player_ID, Throwing_arm)
VALUES
    ('PLAYER009', 'Right'),
    ('PLAYER008', 'Left'),
    ('PLAYER005', 'Right'),
    ('PLAYER006', 'Left'),
    ('PLAYER007', 'Right');


INSERT INTO Stadium (ID, Location, StadiumName, Seats_capacity)
VALUES
    ('STADIUM003', 'Liverpool', 'Anfield', 56000),
    ('STADIUM004', 'Barcelona', 'Camp Nou', 99000),
    ('STADIUM005', 'Milan', 'San Siro', 80000),
    ('STADIUM006', 'Munich', 'Allianz Arena', 75000),
    ('STADIUM007', 'Paris', 'Parc des Princes', 48000);

INSERT INTO Game (Game_ID, HomeClubID, AwayClubID, Age_group, Goals, Stadium_ID, Competition, SeasonYear, Match_Date, Odds, Lineup, Substitutions, Yellow_cards, Red_cards, xG, Ball_possession, Goal_Attempts, Shots_on_Goal, Shots_off_Goal, Blocked_Shots, Corner_kicks, Offsides, Goalkeeper_saves, Fouls, Total_Passes, Completed_Passes, Tackles, Attacks, Dangerous_attacks,League_ID)
VALUES
    ('GAME003', 'LFC', 'FCBAY', 'Senior', 4, 'STADIUM003', 'EPL', '2022-2023','2022-09-10', 2.10, 'Lineup information', 'Substitution details', 1, 2, 1.5, 58, 14, 6, 8, 2, 3, 7, 1, 2, 16, 245, 205, 18, 32, 'EPL'),
    ('GAME004', 'LFC', 'FCBAY', 'Youth', 3, 'STADIUM004', 'Youth League','2022-2023', '2022-09-11', 2.50, 'Lineup information', 'Substitution details', 2, 0, 1.2, 60, 13, 5, 7, 3, 4, 6, 0, 1, 14, 260, 220, 20, 37, 'LaLiga'),
    ('GAME005', 'FCB', 'RMCF', 'Senior', 2, 'STADIUM005', 'SerieA', '2022-2023','2022-09-12', 1.90, 'Lineup information', 'Substitution details', 4, 1, 0.9, 62, 12, 4, 6, 2, 2, 8, 1, 2, 18, 250, 210, 22, 39, 'Ligue1'),
    ('GAME006', 'FCBAY', 'MUFC', 'Senior', 1, 'STADIUM006', 'Bundesliga','2022-2023', '2022-09-13', 2.20, 'Lineup information', 'Substitution details', 2, 1, 1.3, 55, 13, 7, 6, 3, 3, 6, 1, 1, 15, 240, 200, 17, 30,'EPL');
