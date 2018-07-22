library(sqldf)
library(data.table)
library(tidyverse)
library(ggfortify)

setwd("/Users/derekjung/Documents/Data_Science/")

#read files with stat names, if winning team had more than losing team, and matchup ID
win_team_comparison <- read.csv(file="win_team_stats_comparison.csv", header=TRUE, sep=",")

#drop index column
win_team_comparison <- win_team_comparison[c("stat_name", "greater", "matchup_id")]

#find counts of stats and different comparisons 
stats_comparisons_with_ties <- sqldf('SELECT stat_name, 
                                     greater,
                                     COUNT(*) AS occurrences
                                     FROM win_team_comparison
                                     GROUP BY stat_name, greater')

stats_comparisons_with_ties

3392 + 768 + 8731 #12891: number of games over past 5 seasons


#find probabilities of stats and different comparisons
stats_comparisons_with_ties_probs <- sqldf('SELECT stat_name, 
                                           greater,
                                           occurrences/12891.0 AS occurrence_proportion
                                           FROM stats_comparisons_with_ties
                                           GROUP BY stat_name, greater')

stats_comparisons_with_ties_probs

#table compares all stats between winners and losers, counting ties as less for winner
stats_comparisons_no_ties <- read.csv(file="stats_comparison_no_ties.csv", header=TRUE, sep=",")

#drop original index column
stats_comparisons_no_ties <- stats_comparisons_no_ties[c("stat_name", "greater", "matchup_id")]

head(stats_comparisons_no_ties)
nrow(stats_comparisons_no_ties)

#want to append which season each game was played in (represented by final year of season)
#this info is stored in "all_games_04_on.csv"
all_game_info <- read.csv(file="all_games_04_on.csv", header=TRUE, sep=",")

head(all_game_info)

#append year to stats comparison info
stats_comparisons_with_year <- sqldf('SELECT stats_tb.*,  
                                     game_tb.season_end_year
                                     FROM stats_comparisons_no_ties AS stats_tb
                                     LEFT JOIN all_game_info AS game_tb
                                     ON stats_tb.matchup_id = game_tb.matchup_id')

head(stats_comparisons_with_year)

stats_grouped_by_year <- sqldf('SELECT stat_name,
                               season_end_year,
                               greater,
                               COUNT(*) AS num_occurrences
                               FROM stats_comparisons_with_year
                               GROUP BY stat_name, season_end_year, greater')

head(stats_grouped_by_year)

#number of times that winning team had more in statistic by year
stats_grouped_by_year_more <- subset(stats_grouped_by_year, greater == 1)

head(stats_grouped_by_year_more)

#number of times that winning team had at most (less or tie) in statistic by year
stats_grouped_by_year_less <- subset(stats_grouped_by_year, greater == 0)

stats_grouped_by_year_less

#states percentage of games that winning team had more in statistic each year
stats_by_year_percentage <- sqldf('SELECT more_tb.stat_name, 
                                          more_tb.season_end_year, 
                                          ( more_tb.num_occurrences * 100.0 ) / ( more_tb.num_occurrences + less_tb.num_occurrences) AS percent_winner_had_more
                                          FROM stats_grouped_by_year_more AS more_tb
                                          JOIN stats_grouped_by_year_less AS less_tb
                                          ON more_tb.stat_name = less_tb.stat_name
                                          AND more_tb.season_end_year = less_tb.season_end_year')

stats_by_year_percentage #doesn't include points since winning team never has less points
#need to append points manually

ten_years_points_df <- data.frame(c("stat_name" = list(rep("total_points",10)), "season_end_year" = 0, "percent_winner_had_more" = list(rep(100.0,10))))

for (idx in 1:10){
  ten_years_points_df[idx, "season_end_year"] <- idx + 2008
  }

ten_years_points_df

stats_by_year_percentage <- rbind(stats_by_year_percentage, ten_years_points_df)

stats_by_year_percentage

stats_by_year_percentage_2 <- stats_by_year_percentage

legend_order = c("total_points", "assists", "total_rebounds", "threept_made", "offensive_rebounds", "total_turnovers", "personal_fouls")

time_plot <- ggplot(stats_by_year_percentage_2, aes(x=season_end_year, y=percent_winner_had_more, color=stat_name)) + 
  geom_line(size=1) +
  coord_cartesian(ylim = c(0,100)) + 
  labs(title = "NBA winning based on team statistics, 2009-2018",
       subtitle = "Percentage of games that winning team had more of various stats.",
       x = "Final year of season",
       y = "Percentage of games",
       caption = "Source: ESPN.com") +
  theme_minimal() +
  theme(plot.title = element_text(face="bold")) +
  scale_color_discrete(name="", breaks=legend_order, 
                       labels=c("Points", "Assists", "Total rebounds", "3PT'ers made", "Offensive rebounds", "Turnovers", "Personal fouls"))
  
time_plot
