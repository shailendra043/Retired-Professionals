import React from 'react';
import { Link } from 'react-router-dom';
import { ShieldCheck, LineChart, Users, ArrowRight } from 'lucide-react';
import './LandingPage.css';

const LandingPage = () => {
  return (
    <div className="landing-page">
      {/* Hero Section */}
      <section className="hero-section">
        <div className="container hero-content">
          <div className="hero-text">
            <h1 className="animate-fade-in">
              Meaningful Engagement for <span className="text-highlight">Timeless Expertise</span>
            </h1>
            <p className="hero-subtitle animate-fade-in delay-100">
              India's premium marketplace connecting retired professionals aged 50-70 with startups, SMEs, and students.
            </p>
            <div className="hero-actions animate-fade-in delay-200">
              <Link to="/professionals/join" className="btn-primary">
                Join as an Expert <ArrowRight size={20} />
              </Link>
              <Link to="/directory" className="btn-outline">
                Hire an Expert
              </Link>
            </div>
          </div>
          <div className="hero-stats animate-fade-in delay-300">
            <div className="stat-card glass-panel">
              <h3 className="stat-number">2Cr+</h3>
              <p className="stat-label">Senior Professionals</p>
            </div>
            <div className="stat-card glass-panel">
              <h3 className="stat-number">500+</h3>
              <p className="stat-label">Startups Hiring</p>
            </div>
            <div className="stat-card glass-panel">
              <h3 className="stat-number">100%</h3>
              <p className="stat-label">Verified Talent</p>
            </div>
          </div>
        </div>
      </section>

      {/* Value Proposition Section */}
      <section className="value-section container">
        <h2 className="section-title">Why Choose SilverPro?</h2>
        <div className="features-grid">
          <div className="feature-card glass-panel">
            <div className="feature-icon"><ShieldCheck size={32} /></div>
            <h3>Verified Experience</h3>
            <p>Every expert is background verified. We ensure trust and authenticity in every connection.</p>
          </div>
          <div className="feature-card glass-panel">
            <div className="feature-icon"><LineChart size={32} /></div>
            <h3>Drive Growth</h3>
            <p>Access decades of leadership, financial, and strategic experience to scale your SME or Startup.</p>
          </div>
          <div className="feature-card glass-panel">
            <div className="feature-icon"><Users size={32} /></div>
            <h3>Flexible Engagements</h3>
            <p>Mentoring, part-time advisory, or board memberships. Hire exactly what you need.</p>
          </div>
        </div>
      </section>
    </div>
  );
};

export default LandingPage;
