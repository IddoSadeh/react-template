import React from 'react';

const GameForm = ({teamIDs,gameIDs,ageGroupe}) => {
  return (
    <div className="form-container bg-white max-w-md mx-auto p-6 rounded-lg shadow-lg">
      <h2 className="text-2xl font-bold mb-6">Game Update/Creation Form</h2>
      <form action="#" method="post"> 
        <div className="form-group mb-4">
          <label htmlFor="game_id" className="block font-semibold mb-1">Game ID:</label>
          <select id="game_id" name="game_id" className="w-full py-2 px-4 border border-gray-300 rounded-md">
            
          </select>
        </div>
        <div className="form-group mb-4">
          <label htmlFor="homeclubid" className="block font-semibold mb-1">Home Club ID:</label>
          <select id="homeclubid" name="homeclubid" className="w-full py-2 px-4 border border-gray-300 rounded-md">
            
          </select>
        </div>
        <div className="form-group mb-4">
          <label htmlFor="awayclubid" className="block font-semibold mb-1">Away Club ID:</label>
          <select id="awayclubid" name="awayclubid" className="w-full py-2 px-4 border border-gray-300 rounded-md">
            
          </select>
        </div>
        <div className="form-group mb-4">
          <label htmlFor="age_group" className="block font-semibold mb-1">Age Group:</label>
          <select id="age_group" name="age_group" className="w-full py-2 px-4 border border-gray-300 rounded-md">
           
          </select>
        </div>
        
        <button type="submit" className="submit-btn bg-green-500 hover:bg-green-600 text-white py-2 px-4 rounded-md">
          Submit
        </button>
      </form>
    </div>
  );
}

export default GameForm;
