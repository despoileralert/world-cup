"""Written in bash to insert columns of world cup match data from the games.csv file to a PostgreSQL table. 
#!/bin/bash
if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi
# Do not change code above this line. Use the PSQL variable above to query your database.
echo $($PSQL "truncate table games, teams cascade;")
cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNERGOAL OPPONENTGOAL
do
 if [[ $YEAR != "year" ]]
 then
  InsertRow=$($PSQL "INSERT INTO teams(name) values('$WINNER');")
  InsertRow1=$($PSQL "INSERT INTO teams(name) values('$OPPONENT');")
 fi
done
cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNERGOAL OPPONENTGOAL
do
GetWinnerId=$($PSQL "select team_id from teams where name=('$WINNER')")
GetOpponentId=$($PSQL "select team_id from teams where name=('$OPPONENT')")
  if [[ $YEAR != "year" ]]
  then
    InsertRow3=$($PSQL "INSERT INTO games(year, round, winner_id, opponent_id, winner_goals, opponent_goals) values($YEAR, '$ROUND', $GetWinnerId, $GetOpponentId, $WINNERGOAL, $OPPONENTGOAL);")
  fi
 done
