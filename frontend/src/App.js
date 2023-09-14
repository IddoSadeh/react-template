import { BrowserRouter, Routes, Route } from "react-router-dom";
import "./App.css";
import HomePage from "./components/HomePage/HomePage";
import Navbar from "./components/Navigation/Navbar";
import Footer from "./components/Navigation/Footer";
import PlayerStats from "./components/Players/PlayerStats";
import GameStats from "./components/Games/GameStats";

function App() {
  return (
    <div className="App">
      <BrowserRouter>
        <Navbar />
        <Routes>
          <Route exact path="/" element={<HomePage />} />
          <Route exact path="/players" element={<PlayerStats />} />
          <Route exact path="/games" element={<GameStats />} />
        </Routes>
        <Footer />
      </BrowserRouter>
    </div>
  );
}

export default App;
