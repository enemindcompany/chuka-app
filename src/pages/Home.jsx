import { Link } from "react-router-dom";

const features = [
  ["Explore Chuka", "/explore", "Find places, services and useful locations around Chuka."],
  ["Accommodation", "/accommodation", "Hostels, bedsitters, rooms and places to stay."],
  ["Food", "/food", "Discover food spots, menus, prices and delivery options."],
  ["Academics", "/academics", "Courses, resources, past papers and academic information."],
  ["eFootball", "/efootball", "Tournaments, players, fixtures and rankings."],
  ["Marketplace", "/marketplace", "Buy and sell useful student items."],
  ["Jobs & Gigs", "/jobs", "Find campus work, attachments and opportunities."],
  ["Connections", "/connections", "Connect around interests, study, sports and communities."],
  ["Events", "/events", "Discover what's happening around Chuka."],
  ["Chuka Stories", "/stories", "Share experiences, tips, memories and advice."],
];

function Home() {
  return (
    <main>
      <nav className="nav">
        <Link to="/" className="brand">CHUKA</Link>
        <Link to="/explore" className="nav-link">Explore Chuka</Link>
      </nav>

      <section className="hero">
        <span className="eyebrow">CHUKA UNIVERSITY • MAIN CAMPUS</span>
        <h1>Everything Chuka.<br /><span>In one place.</span></h1>
        <p>
          Find places, services, opportunities, events and student resources
          around Chuka.
        </p>

        <div className="search">
          <span>?</span>
          <input placeholder="What do you need in Chuka?" />
        </div>

        <div className="hero-actions">
          <Link to="/explore" className="primary-btn">Explore Chuka</Link>
          <Link to="/add-place" className="secondary-btn">+ Add a place</Link>
        </div>
      </section>

      <section className="section">
        <div className="section-heading">
          <div>
            <span className="eyebrow">STUDENT HUB</span>
            <h2>What do you need?</h2>
          </div>
          <Link to="/explore">View all ?</Link>
        </div>

        <div className="feature-grid">
          {features.map(([title, path, description]) => (
            <Link to={path} className="feature-card" key={path}>
              <h3>{title}</h3>
              <p>{description}</p>
              <span>Explore ?</span>
            </Link>
          ))}
        </div>
      </section>

      <section className="cta">
        <div>
          <span className="eyebrow">COMMUNITY POWERED</span>
          <h2>Know a useful place?</h2>
          <p>Help other students discover it. Anyone can suggest a place.</p>
        </div>
        <Link to="/add-place" className="primary-btn">Add a place</Link>
      </section>

      <footer>
        <strong>CHUKA</strong>
        <span>Built for the Chuka student community.</span>
      </footer>
    </main>
  );
}

export default Home;
