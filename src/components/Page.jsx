import { Link } from "react-router-dom";

function Page({ title, description }) {
  return (
    <main className="simple-page">
      <Link to="/" className="back">? Chuka</Link>
      <span className="eyebrow">CHUKA</span>
      <h1>{title}</h1>
      <p>{description}</p>
      <Link to="/explore" className="primary-btn">Explore Chuka</Link>
    </main>
  );
}

export default Page;
