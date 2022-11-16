#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.

echo $($PSQL "TRUNCATE teams, games")

cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do
  
  #INSERT WINNER
  if [[ $WINNER != "winner" ]]
  then
    # get team_id
    TEAM_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")

    #IF NOT found 
   # insert team
    INSERT_TEAMS_RESULT=$($PSQL "INSERT INTO teams(name) VALUES('$WINNER')")    
      echo $INSERT_TEAMS_RESULT
  
  if [[ $INSERT_TEAMS_RESULT == "INSERT 0 1" ]]
      then
        echo Inserted into teams, $WINNER
      fi
   # get NEW team_id
    TEAM_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
fi

  #INSERT OPPONENT
  if [[ $OPPONENT != "opponent" ]]
  then
    # get team_id
    TEAM_IDS=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")

    #IF NOT found 
   # insert team
    INSERT_TEAMS_RESULTW=$($PSQL "INSERT INTO teams(name) VALUES('$OPPONENT')")
    
      echo $INSERT_TEAMS_RESULTW
  
    if [[ $INSERT_TEAMS_RESULTW == "INSERT 0 1" ]]
      then
        echo Inserted into teams, $OPPONENT
      fi
  # get NEW team_id
    TEAM_IDS=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")
  fi

  if [[ $YEAR != "year" ]]
  then
  # get games_id
  GAMES_ID=$($PSQL "SELECT game_id FROM games WHERE year='$YEAR'")
  fi
  #if not found
  #insert games values   
  INSERT_GAMES_RESULT=$($PSQL "INSERT INTO games(year, round, winner_goals, opponent_goals, winner_id, opponent_id) VALUES($YEAR, '$ROUND', $WINNER_GOALS, $OPPONENT_GOALS, $TEAM_ID, $TEAM_IDS)")
  if [[ $INSERT_GAMES_RESULT == "INSERT 0 1" ]]
      then
        echo Inserted into games, $YEAR, $ROUND, $WINNER_GOALS, $OPPONENT_GOALS
      fi
done