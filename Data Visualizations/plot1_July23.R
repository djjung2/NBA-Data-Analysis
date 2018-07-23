#Plot 1 code:

#Bar plot of number of wins and losses based on player accomplishment occurring in game
#(for example, a player scored at least 40 points, a player having at least 15 rebounds, etc.)

library(sqldf)
library(data.table)
library(tidyverse)
library(ggfortify)

setwd("/Users/derekjung/Documents/Data_Science/")

#player statistics from all games in 2017-2018 season
player_stats_2018 <- read.csv(file="players_stats_2018_cleaned.csv", header=TRUE, sep=",")
player_stats_2017 <- read.csv(file="players_stats_2017_cleaned.csv", header=TRUE, sep=",")
player_stats_2016 <- read.csv(file="players_stats_2016_cleaned.csv", header=TRUE, sep=",")
player_stats_2015 <- read.csv(file="players_stats_2015_cleaned.csv", header=TRUE, sep=",")
player_stats_2014 <- read.csv(file="players_stats_2014_cleaned.csv", header=TRUE, sep=",")

#player statistics of all games from '13-'14 season to '17-'18 season
player_stats_2014_to_2018 = rbind(player_stats_2018, player_stats_2017, player_stats_2016, player_stats_2015, player_stats_2014)


#team statistics for 2017-2018 season (contains which team won)
all_team_stats <- read.csv(file="all_team_stats_2009_to_2018.csv", header=TRUE, sep=",")


#by game and team, find max of all statistics except for free throws and personal fouls
player_stats_max <- sqldf('SELECT matchup_id, 
                          team_name, 
                          MAX(minutes) AS most_minutes, 
                          MAX(fg_made) AS most_fg_made, 
                          MAX(fg_attempted) AS most_fg_attempted, 
                          MAX(three_pt_made) AS most_three_pt_made,
                          MAX(three_pt_attempted) AS most_three_pt_attempted, 
                          MAX(reb) AS most_reb,
                          MAX(oreb) AS most_oreb,
                          MAX(dreb) AS most_dreb, 
                          MAX(ast) AS most_ast, 
                          MAX(stl) AS most_stl, 
                          MAX(blk) AS most_blk, 
                          MAX(pf) AS most_pf, 
                          MAX("to") AS most_to, 
                          MAX(pts) AS most_pts 
                          FROM player_stats_2014_to_2018 
                          GROUP BY matchup_id, team_name')


#append whether team won or loss
player_stats_max_win <- sqldf('SELECT player_tb.*, 
                              team_tb.won 
                              FROM player_stats_max AS player_tb 
                              LEFT JOIN all_team_stats AS team_tb 
                              ON player_tb.matchup_id = team_tb.matchup_id 
                              AND player_tb.team_name = team_tb.team')

#find summary statistics 
summary_player_max <- summary(player_stats_max_win[3:ncol(player_stats_max_win)])

#append row with standard deviation
summary_player_max <- rbind(summary_player_max, sapply(player_stats_max_win[3:ncol(player_stats_max_win)], sd))


head(player_stats_max_win)

#find number of games that player did different statistical game accomplishments
#keep track of if team won or lost
count_thirty_points <- sqldf('SELECT won, 
                             COUNT(*) AS scored_thirty_plus
                             FROM player_stats_max_win 
                             WHERE most_pts >= 30 
                             GROUP BY won')

count_forty_points <- sqldf('SELECT won, 
                            COUNT(*) AS scored_forty_plus
                            FROM player_stats_max_win 
                            WHERE most_pts >= 40 
                            GROUP BY won')

count_forty_minutes <- sqldf('SELECT won, 
                             COUNT(*) AS played_forty_plus
                             FROM player_stats_max_win 
                             WHERE most_minutes >= 40
                             GROUP BY won')

count_fifteen_rebounds <- sqldf('SELECT won, 
                                COUNT(*) AS fifteen_rebounds
                                FROM player_stats_max_win 
                                WHERE most_reb >= 15
                                GROUP BY won')


count_ten_assists <- sqldf('SELECT won, 
                           COUNT(*) AS ten_assists
                           FROM player_stats_max_win 
                           WHERE most_ast >= 10
                           GROUP BY won')

count_five_threept <- sqldf('SELECT won,
                            COUNT(*) AS five_three_pt
                            FROM player_stats_max_win
                            WHERE most_three_pt_made >= 5
                            GROUP BY won')

count_five_to <- sqldf('SELECT won,
                       COUNT(*) AS five_to
                       FROM player_stats_max_win
                       WHERE most_to >= 5
                       GROUP BY won')

#merge over all statistical accomplishments
merged_df <- sqldf('SELECT tb1.won, 
                   tb1.scored_thirty_plus, 
                   tb2.scored_forty_plus, 
                   tb3.played_forty_plus, 
                   tb4.fifteen_rebounds,
                   tb5.ten_assists,
                   tb6.five_three_pt,
                   tb7.five_to
                   FROM count_thirty_points AS tb1 
                   JOIN count_forty_points AS tb2 
                   ON tb1.won = tb2.won 
                   JOIN count_forty_minutes AS tb3 
                   ON tb2.won = tb3.won 
                   JOIN count_fifteen_rebounds AS tb4 
                   ON tb3.won = tb4.won
                   JOIN count_ten_assists AS tb5
                   ON tb4.won = tb5.won
                   JOIN count_five_threept AS tb6
                   ON tb5.won = tb6.won
                   JOIN count_five_to AS tb7
                   ON tb6.won = tb7.won')

merged_df

#table of accomplishment with how many games team won or lost when accomplishment occurred
merged_df_rotate <- data.frame( "won" = as.numeric(merged_df[2,2:ncol(merged_df)]), 
                                "lost" = as.numeric(merged_df[1,2:ncol(merged_df)]),
                                "stat_name" = as.vector(names(merged_df)[2:ncol(merged_df)]))
merged_df_rotate


won_df_rotate <- sqldf('SELECT won AS num_games, stat_name, "Wins" AS win_or_lose FROM merged_df_rotate')

lost_df_rotate <- sqldf('SELECT lost AS num_games, stat_name, "Losses" AS win_or_lose FROM merged_df_rotate')

# table with accomplishment, result, and number of games that result occurred given accomplishment
df_with_win_stat <- rbind(won_df_rotate, lost_df_rotate)


merged_df_rotate_ratio <- sqldf('SELECT *, won/lost AS wl_ratio
                                FROM merged_df_rotate')

merged_df_rotate_ratio


df_with_win_stat$stat_name <- factor(df_with_win_stat$stat_name, levels=df_with_win_stat$stat_name[order(merged_df_rotate_ratio$wl_ratio)])


#change order of stats in bar plot
reordered_labels <- c("scored_thirty_plus", "scored_forty_plus", "five_three_pt", "ten_assists", "fifteen_rebounds", "played_forty_plus", "
                      five_to")

#change appearance of tick marks on axis
common_stat_names = rev(c("40+ points", "5+ 3PT made", "30+ points", "10+ assists", "15+ rebounds", "40+ minutes", "5+ turnovers"))

#make bar plot of number of wins and losses based on accomplishment occurring
dodge_bar <- ggplot(data = df_with_win_stat, aes(x=stat_name, y=num_games, fill=win_or_lose, order=rev(win_or_lose))) + 
  geom_bar(stat="identity", width=0.5, position=position_dodge()) + 
  theme_minimal() +
  scale_fill_manual(values = c("coral1", "royalblue")) +
  labs(title="NBA wins and losses by player statistics, 2014-2018",
       subtitle="Game outcomes for teams with a player doing accomplishment.",
       y = "Number of games", caption="Source: ESPN.com") +
  guides(fill=guide_legend(reverse=TRUE, title="")) +
  scale_x_discrete(name="", labels=common_stat_names) + 
  theme(plot.title = element_text(lineheight=1, face="bold")) +
  coord_flip()

dodge_bar
