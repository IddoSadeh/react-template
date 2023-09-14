export const getPlayerUpdateURL = (playerId) => `/players/update/${playerId}`; //PUT
export const getPlayerCreationURL = (clubId) => `/players/add/${clubId}`; //POST
export const getPlayerStatsURL = (leagueId, gameId) =>
  `/players/stats/${leagueId}/${gameId}`; //PUT
export const getPlayerStatsUpdateURL = (leagueId, gameId) =>
  `/players/stats/update/${leagueId}/${gameId}`; //DELETE
