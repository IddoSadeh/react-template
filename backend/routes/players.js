const express = require('express');
const router = express.Router();
const controllers = require("../controllers/players");

router.get("/update", controllers.getPlayerStats);
router.delete("/delete/:playerId", controllers.deletePlayer); 

module.exports = router;
