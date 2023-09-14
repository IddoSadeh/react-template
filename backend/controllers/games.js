const db = require("../config/db");

const updateGame = async (req, res) => {
  const { leagueId, gameId } = req.params;
  const updates = req.body;
  //On the frontend, make sure that data is sent as a Object whoses
  // keys are names exactly like the attributes of Game
  try {
    const query = `
      UPDATE Game
      SET  ${updates},   
      WHERE Game_ID = ${gameId};
    `;
    await db.query(query);
    return res.status(200).json({ message: "Game updated successfully" });
  } catch (error) {
    console.error("Error updating game attributes:", error);
    return res
      .status(200)
      .json({ message: "Game could not be updated, something went wrong!" });
  }
};

const getGames = async (req, res) => {
  const query = ` SELECT *
                FROM Game `;

  try {
    const data = await db.query(query);
    let colnames = [];
    if (data?.rows && data?.rows.length > 0) {
      const row = data.rows[0];
      colnames = Object.keys(row);
    }
    return res.status(200).json({ rows: data.rows, colnames: colnames });
  } catch (error) {
    console.log(error.message);
    return res.status(404).json({ message: "Oh no, something went wrong!" });
  }
};
module.exports = { updateGame, getGames };
