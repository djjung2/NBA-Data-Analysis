# Plot 2

![plot2](https://github.com/djjung2/NBA-Data-Analysis/blob/master/Data%20Visualizations/Plot2_July22.png)

# Content

This time series plot is based on the past 10 years of NBA games. The data was collected from ESPN.com.

For each of 7 statistics, I determined in what percentage of games the winning team had more of that statistic each season.
The 7 statistics are Points, Assists, Total rebounds, Three-pointers made, Offensive rebounds, Turnovers, and Personal fouls.

For example, the winning team scores more points than the losing team in every game. 
This explains why Points is listed as 100% each season.

The stat names in the legend are listed in the same order as they appear for 2008-2009 season.

# Creation of plot

I began with team stats data collected from ESPN.com.

For each game, I used Python to find the difference between the winning and losing teams for the 7 statistics above.

I then used R to find in what percentage of games the winning team had more of each statistic, grouping by season.
I graphed the multiple time series using `ggplot2`. 

# Insights

It is reassuring to know that the winning team scored more points than the losing team in every game of the past 10 seasons.
(There could have been some weird game in which a team was leading before being forced to forfeit. More likely, it could have been that points were incorrectly inputted on ESPN.com.)

With the emphasis on ball movement and three-point shooting, it is good to see that this shows up in the fact that assists and three-pointers are positvely correlated with winning.

It is interesting that the winning team has more rebounds about 60% of games, but more offensive rebounds only about 44% of games.
I think this is because offensive rebounds are usually gotten by larger often slower players, and successful teams now tend to run smaller, faster lineups.

As expected, winning teams tend to give up less turnovers and personal fouls. 
Turnovers often lead to fastbreak points for the other team and personal fouls often lead to free throws, hence more points for the other team. 

# Case of ties

A natural question to ask is what happens when the winning team and losing team tie in a statistic.
In this case, the winning team did NOT have more of that statistic than the losing team.
I treated it this way in the plot.

I kept track of what percentage of games each statistic ended in a tie. This is what I found:

- points: 0% of games (the winning team always scores more points, to the best of my knowledge)
- assists: 5.96% of games
- offensive rebounds: 8.01% of games
- personal fouls: 7.32%
- three point shots made: 8.83%
- total rebounds: 3.87% 
- total_turnovers: 8.07%
