![plot1](https://github.com/djjung2/NBA-Data-Analysis/blob/master/Data%20Visualizations/Plot1_July23.png)

# Content

This chart shows the game outcomes for teams when a player performs various statistical accomplishments over the past five seasons.

For example, the chart shows teams won almost twice as many games as they lost, when a player on the team scored at least 40 points.

The labels on the vertical axis are arranged by decreasing win/loss ratio.

# Creation of plot

The data was collected from box scores and team statistics tables from ESPN.com.

For processing my data, I used R and its `sqldf` library to run SQL queries.
From a table of player statistics, I found the maximum of points, three-pointers made, assists, rebounds, minutes, and turnovers by players, grouped by game and team.
I then joined the team statistics table, to attach to each row whether the team won or lost.
For each accomplishment, I then counted the number of games that were won or lost when a player achieved that accomplishment.

To visualize the data, I used the `ggplot2` library. 

# Insights

I found that having players with high numbers of points scored, rebounds, assists, or three-pointers made were positively correlated with winning.
These weren't very surprising.

The one surprising thing of this graph was what happens when coaches play a player for at least 40 minutes.
And I mention the coach because it is their responsibility for determining how long players are in the game.
Note that each basketball game consists of 4 quarters of 12 minutes for a total of 48 minutes, unless the game goes into overtime.
One might have guessed that a player playing a lot would be positively correlated with winning. 
Perhaps coaches leave players in when they are playing well and helping out the team more than anyone else could.
However, this suggests that leaving players in actually hurts the team.
More research needs to be done on the effect of leaving players in on winning games (and injuries from fatigue). 
