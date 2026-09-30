import { BrowserRouter, Routes, Route } from "react-router-dom";
import Home from "./pages/Home";
import Explore from "./pages/Explore";
import Accommodation from "./pages/Accommodation";
import Food from "./pages/Food";
import Academics from "./pages/Academics";
import EFootball from "./pages/EFootball";
import Marketplace from "./pages/Marketplace";
import Jobs from "./pages/Jobs";
import Connections from "./pages/Connections";
import Events from "./pages/Events";
import Stories from "./pages/Stories";
import AddPlace from "./pages/AddPlace";
import NotFound from "./pages/NotFound";
import "./index.css";

function App() {
  return (
    <BrowserRouter>
      <Routes>
        <Route path="/" element={<Home />} />
        <Route path="/explore" element={<Explore />} />
        <Route path="/accommodation" element={<Accommodation />} />
        <Route path="/food" element={<Food />} />
        <Route path="/academics" element={<Academics />} />
        <Route path="/efootball" element={<EFootball />} />
        <Route path="/marketplace" element={<Marketplace />} />
        <Route path="/jobs" element={<Jobs />} />
        <Route path="/connections" element={<Connections />} />
        <Route path="/events" element={<Events />} />
        <Route path="/stories" element={<Stories />} />
        <Route path="/add-place" element={<AddPlace />} />
        <Route path="*" element={<NotFound />} />
      </Routes>
    </BrowserRouter>
  );
}

export default App;
