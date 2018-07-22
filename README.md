# NBA Data Analysis

This project aims to determine the primary factors towards winning games in the National Basketball Association (NBA) today by analyzing player and team statistics over the past 10 seasons. 

I use Python to develop the project from end-to-end: I webscrape, organize, clean, visualize, and analyze data.
I comment code and lead the reader through my thinking.

# Motivation

By identifying the factors most related to winning, NBA teams can emphasize certain play styles and target players to acquire. With each team allowed to only have 15 players on the roster at once (technically two more players can be kept in the D-League), it is vital that each player is carefully chosen to contribute.


Each NBA team could be viewed as a billion dollar business. 

- As of February 2018 according to [Forbes:](https://www.forbes.com/sites/forbespr/2018/02/07/forbes-releases-20th-annual-nba-team-valuations/#6d41a85034e6) each NBA team is worth at least a billion dollars with the New York Knicks with the highest valuation at $3.6 billion. 

- Acquiring players should be seen as investments. Last season, the minimum NBA salary was [$562,493](http://www.basketballinsiders.com/nba-salaries/nba-minimum-salary/), the mean salary was [$5,752,807](https://www.basketball-reference.com/contracts/players.html), and the max salary was Steph Curry's [$34,682,550](https://www.basketball-reference.com/contracts/players.html). 

The stakes for choosing and directing NBA teams are high.

# Features

These programs lead one through how to do a webscraping data analysis project from the beginning. It begins by scraping data from a website and cleaning this data using (primarily) the Python libraries Pandas, requests, BeautifulSoup, and SQLite. It then brings up questions one can ask of this data, then providing answers through machine learning and visualization methods via scikit-learn and Matplotlib.


# Overview

I start by using the Python libraries requests, BeautifulSoup, Pandas, and SQLite to webscrape from ESPN.com, organize, and clean team and player statistics from nearly all NBA games over the past 10 seasons (nearly 13,000 games). I then show that the Hollinger Game Score, a game statistic developed by NBA Data Analyst/current Vice President of Basketball Operations for the Memphis Grizzlies John Hollinger, classified winning based on team statistics with 94% accuracy last season. I then do some machine learning classification of winning.

I begin by collecting team statistics from tables (one for each NBA game) that look like

![Game 4 Team Stats table](https://github.com/djjung2/NBA-Data-Analysis/blob/master/Images/team_stats_table.png)

using team schedules (regular season for each team and year, and postseason for teams that made playoffs) that look like

![Game Schedule](https://github.com/djjung2/NBA-Data-Analysis/blob/master/Images/team_schedule.png)

to collect stats from over 12,900 games since the 2009-2010 season. We stored this in a CSV file with over 25,000 records, for which the first few rows begin as 

![Team Screenshot](https://github.com/djjung2/NBA-Data-Analysis/blob/master/Images/team%20stats%20table%20screen.png)

We then do the same for player statistics, scraping from box scores that look like 

![Box score screenshot](https://github.com/djjung2/NBA-Data-Analysis/blob/master/Images/box%20score%20screenshot.png)

You may notice the url is followed by a 9-digit number, which is the unique Matchup ID assigned to the game, which I scraped earlier from the team schedules pages. 

This resulted in a file of player statistics since the 2004-2005 season of around 480,000 records, of which the first few rows began as

![Player file](https://github.com/djjung2/NBA-Data-Analysis/blob/master/Images/Player%20stats%20table.png)

I then do data analysis, classifying wins by team statistics. The most interesting statistic I found was developed by John Hollinger, an NBA data analyst. He designed the score to measure a player's performance in a game, and it is given by the formula

PTS + 0.4 * FG - 0.7 * FGA - 0.4*(FTA - FT) + 0.7 * ORB + 0.3 * DRB + STL + 0.7 * AST + 0.7 * BLK - 0.4 * PF - TOV,

where abbreviations are mostly intuitive for NBA fans and can be found on Hollinger's [Wikipedia page](https://en.wikipedia.org/wiki/John_Hollinger). This statistic classified wins with great accuracy from the 2017-2018 (over 94%) and should be analyzed further.

I also compare several machine learning methods for classifying wins based on team stats over the past two seasons.


# Contents

The djjung2/NBA-Data-Analysis repository consists of 5 folders:

- **ALL Data**: Includes all of the NBA data I collected and cleaned from ESPN.com.

- **CollectingPlayerStats**: The two Jupyter files collect and clean player stats from almost every game (over 98%) played since the 2009-2010 seasons. (We ignore some games due to critical errors during webscraping and the lack of a desire to perform ad hac extraction methods.) Included are CSV files that contain the cleaned player data, with name of the form "player\_stats\_{year}\_cleaned.csv".

- **CollectingTeamStats**: The programs here progress from scraping the team stats table of a single game to scraping the team stats tables of entire seasons. Included are also the team stats of all games played since the 2009-2010 season, written in the CSV file "all_team_stats_2009_to_2018.csv".

- **Data Visualizations**: Included are two plots I created using R. One analyzes winning based on team statistics and the other analyzes winning based on player statistics. 

- **GeneralGameInfo**: The programs here collect and organize general game information (one team playing, date of game, game-specific MatchupID, and whether it is a regular season or postseason game) of all games since the 2003-2004 season. Included is a file containing all of this information, named "all_games_04_on.csv".

- **Images**: This contains the images used in this README.

- **TeamStatsAnalysis**: These programs do analysis on team stats. Most interesting is the adaption of the Hollinger Game Score to classify wins, found in "Analyzing importance of game scores-June19.ipynb" and "Classification with team game scores-June20.ipynb". In the latter notebook, we classify winning during the '17-'18 season using this game score, with over 94\% accuracy. I also compare different machine learning methods for classifying wins in "Classification with 2017 and 2018 team stats- June29.ipynb".


# Future projects

A person interested in this project could modify my programs to analyze another sport, such as NFL. I think it would be really interesting to develop a player statistic for the performance of NFL players. This has already been developed for quarterbacks (passer rating and QB rating), but it would be interesting to standardize this across all positions. How does one measure the value of an offensive tackle? Of a punter? How should their performances compare? The NFL is far less developed in terms of well-known statistics that identify the value of players. 


# Credits

By using data from ESPN.com, I agree to Disney's term of service, especially not making money off of this project. Thank you ESPN for compiling and making this data available!


©️djjung2
