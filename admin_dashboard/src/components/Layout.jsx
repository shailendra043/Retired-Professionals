import React from 'react';
import { Outlet, Link } from 'react-router-dom';
import { Briefcase, Settings, LogIn } from 'lucide-react';
import './Layout.css';

const Layout = () => {
  return (
    <div className="layout-container">
      <nav className="navbar glass-panel">
        <div className="nav-content container">
          <Link to="/" className="nav-logo">
            <span className="logo-icon">⭐</span>
            <span className="logo-text">SilverPro</span>
          </Link>
          <div className="nav-links">
            <Link to="/directory" className="nav-link"><Briefcase size={20}/> Find Experts</Link>
            <Link to="/admin" className="nav-link"><Settings size={20}/> Dashboard</Link>
          </div>
          <div className="nav-actions">
            <button className="btn-outline"><LogIn size={20}/> Login</button>
            <button className="btn-primary">Join as Expert</button>
          </div>
        </div>
      </nav>

      <main className="main-content">
        <Outlet />
      </main>

      <footer className="footer glass-panel">
        <div className="container footer-content">
          <div className="footer-brand">
            <span className="logo-text">SilverPro</span>
            <p>Empowering the experience economy. Connect with seasoned 50-70+ experts.</p>
          </div>
        </div>
      </footer>
    </div>
  );
};

export default Layout;
