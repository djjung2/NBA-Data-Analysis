# NBA Data Analysis

This project aims to determine the primary factors towards winning games in the National Basketball Association (NBA) today by analyzing player and team statistics over the past 10 seasons. 

I use Python to develop our project from end-to-end: I webscrape, organize, clean, visualize, and analyze data.
I comment code and lead the reader through my thinking throughout.

# Motivation

By identifying the factors most related to winning, NBA teams can emphasize certain play styles and target players to acquire. With each team allowed to only have 15 players on the roster at once (technically two more players can be kept in the D-League), it is vital that each player is carefully chosen and contributes.


Each NBA team could be viewed as a billion dollar business. 

- As of February 2018 according to [Forbes:](https://www.forbes.com/sites/forbespr/2018/02/07/forbes-releases-20th-annual-nba-team-valuations/#6d41a85034e6) each NBA team is worth at least a billion dollars with the New York Knicks with the highest valuation at $3.6 billion. 

- Acquiring players should be seen as investments. Last season, the minimum NBA salary was [$562,493](http://www.basketballinsiders.com/nba-salaries/nba-minimum-salary/), the mean salary was [$5,752,807](https://www.basketball-reference.com/contracts/players.html), and the max salary was Steph Curry's [$34,682,550](https://www.basketball-reference.com/contracts/players.html). 

The stakes for choosing and directing NBA teams are high.

# Contents

The djjung2/NBA-Data-Analysis repository consists of 4 folders:

- **CollectingPlayerStats**: The two Jupyter files collect and clean player stats from almost every game (over 98%) played since the 2009-2010 seasons. (We ignore some games due to critical errors during webscraping and the lack of a desire to perform ad hac extraction methods.) Included are CSV files that contain the cleaned player data, with name of the form "player\_stats\_{year}\_cleaned.csv".

- **CollectingTeamStats**: These programs progress from scraping the team stats table of a single game to scraping the team stats tables of entire seasons. Included are also the team stats of all games played since the 2009-2010 season, written in the CSV file "all_team_stats_2009_to_2018.csv".

- **GeneralGameInfo**: These programs collect and organize general game information (one team playing, date of game, game-specific MatchupID, and whether it is a regular season or postseason game) of all games since the 2003-2004 season. Included is a file containing all of this information, named "all_games_04_on.csv".

- **TeamStatsAnalysis**: These programs do analysis on team stats. Most interesting is the adaption of the Hollinger Game Score to classify wins, found in "Analyzing importance of game scores-June19.ipynb" and "Classification with team game scores-June20.ipynb". In the latter notebook, we classify winning during the '17-'18 season using this game score, with over 94\% accuracy. In the notebook 


