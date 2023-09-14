import React, { useEffect, useState } from "react";
import { API } from "../../api";
import { gameStatsURL } from "../../api/games";
import GamesTable from "./GamesTable";

const GameStats = () => {
  const [games, setGames] = useState([]);
  const[colnames,setColnames] = useState([])
  const [loading, setLoading] = useState(true);
  useEffect(() => {
    API.get(gameStatsURL).then((res) => {
      const data = res?.data
      setGames(data?.rows);
      setColnames(data?.colnames);
      setLoading(false);
    });
  }, []);

  let content;
  if (loading) {
    content = (
      <div>
        <h1>Loading...</h1>
      </div>
    );
  } else {
    content = <div className="inline-block max-w-full"><GamesTable rows={games} colnames={colnames} /></div>;
  }

  return <div className="h-screen">{content}</div>;
};

export default GameStats;
