export const getGameUpdateURL = "games/update"; //PUT
export const getGameCreationURL = (leagueId) => `/games/add/${leagueId}`; //POST
export const gameStatsURL = `/games/all`; //PUT
export const getGameStatsUpdateURL = (leagueId,gameId) => `/games/stats/update/${leagueId}/${gameId}`; //DELETE
  