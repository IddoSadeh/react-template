const { query } = require("express");
const db = require("../config/db");

const getPlayerStats = async (req, res) => {
  const { criteria } = req.params;

  // Initialize an array to hold the WHERE clause conditions
  const whereConditions = [];
  Object.keys(criteria).forEach((attribute) => {
    whereConditions.push(`${attribute} = ?`);
  });
  // Constructing the WHERE clause by joining the conditions with 'AND'
  const whereClause = whereConditions.join(" AND ");

  const values = Object.values(criteria);
  query = `SELECT
    p.ID,
    p.First_name,
    p.Last_name,
    p.Number,
    p.Age AS Player_Age,
    p.Height,
    p.Weight,
    p.Position,
    p.Active_foot,
    p.Nationality,
    pb.birthdate AS Date_of_Birth,
    s.Game_ID,
    s.Minutes_played,
    s.Assists,
    s.Goals,
    s.Shots_taken,
    s.Shots_on_goal,
    s.Shots_taken_inside_box,
    s.Shots_taken_outside_box,
    s.Passes_attempted,
    s.Passes_complete,
    s.Key_passes_attempted,
    s.Key_passes_completed,
    s.Crosses,
    s.Aerial_challenges_attempted,
    s.Aerial_challenges_success
FROM
    PlayerGeneralInfo p
JOIN
    PlayerBirthInfo pb ON p.birthdate = pb.birthdate
LEFT JOIN
    Statistics_Per_Game_Per_Player s ON p.ID = s.Player_ID
WHERE ${whereClause};

`;
  try {
    // allow user to select position, club,team, league, age, nationality
    result = await db.query(query, values);
    //pool.end();
    return res.status(200).json({ data: result.rows });
  } catch (error) {
    console.log(error.message)
    return res.status(404).json({ message: "Something went wrong" });
  }
};

module.exports = {getPlayerStats}