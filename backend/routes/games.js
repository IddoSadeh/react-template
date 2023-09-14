const express = require('express');
const router = express.Router();
const controllers = require("../controllers/games")



router.put("/update",controllers.updateGame)
router.get("/all",controllers.getGames)

module.exports = router;