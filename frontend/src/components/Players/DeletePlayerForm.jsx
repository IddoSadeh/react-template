import React, { useState } from 'react';
import { API } from "../../api";
import { deletePlayerURL } from '../../api/players';

const DeletePlayerForm = () => {
  const [playerId, setPlayerId] = useState('');

  const handleInputChange = (e) => {
    setPlayerId(e.target.value);
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    if (window.confirm('Are you sure you want to delete this player? This action cannot be undone.')) {
      try {
        await API.delete(deletePlayerURL(playerId));
        alert('Player deleted successfully!');
        setPlayerId('');
      } catch (error) {
        alert('Something went wrong! Please check if the player ID is correct.');
        console.error(error);
      }
    }
  };

  return (
    <div>
      <form onSubmit={handleSubmit}>
        <label>
          Player ID:
          <input type="text" value={playerId} onChange={handleInputChange} />
        </label>
        <button type="submit">Delete Player</button>
      </form>
    </div>
  );
};

export default DeletePlayerForm;
