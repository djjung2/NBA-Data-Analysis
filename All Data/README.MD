# NBA Game Data from past 15 seasons

This folder contains approximately 45 MB of player, team, and game statistics from games over the past 15 NBA seasons.
The one field that links all of these files is that each row includes a "Matchup ID", a 9-digit integer that is unique 
to each game. This allows us to join several tables to describe specific games.

There are three main types of files in this folder:

1. General game information: These are located in "all_games_04_on.csv" and "all_regular_season_games_since_ohfour.csv". 
This file contains information on all NBA games since the 2004-2005 season, such as:
  when the game occurred, 
  which season it occurred in, 
  and whether it's a regular or postseason game. 
This file is especially useful because it's the only type of file that states when each game is played.

2. Game team statistics: This is located in the file "all_team_stats_2009_to_2018.csv".
This file provides the team statistics (one for home team and one for away) for each game played since the 2008-2009 season.
These statistics include all of the traditional ones, including total points scored, assists, and rebounds.

3. Player team statistics: These are located in the other files (which all have "players" in the file name).
These includes all of the common player statistics, including turnovers, points scored, and defensive rebounds.