import React, { useState } from 'react';
import { Search, Filter, Star, Clock, CheckCircle, X, ArrowRight } from 'lucide-react';
import './ClientDirectory.css';

// Mock data
const MOCK_EXPERTS = [
  { id: 1, name: 'Anand Sharma', role: 'Ex-SBI Branch Manager', industry: 'Banking & Finance', exp: 30, rate: 1500, rating: 4.9, img: 'AS' },
  { id: 2, name: 'Dr. Meena Iyer', role: 'Retired College Principal', industry: 'Education', exp: 35, rate: 1200, rating: 5.0, img: 'MI' },
  { id: 3, name: 'Rajiv Desai', role: 'Former VP Engineering, L&T', industry: 'Engineering', exp: 28, rate: 2500, rating: 4.8, img: 'RD' },
  { id: 4, name: 'Sunita Menon', role: 'Ex-CMO, FMCG Sector', industry: 'Corporate Leadership', exp: 25, rate: 2000, rating: 4.9, img: 'SM' },
];

const ClientDirectory = () => {
  const [searchTerm, setSearchTerm] = useState('');
  const [selectedIndustry, setSelectedIndustry] = useState('');
  const [selectedExpert, setSelectedExpert] = useState(null);
  const [bookingStep, setBookingStep] = useState(0); // 0=closed, 1=details, 2=simulated payment, 3=success

  const filteredExperts = MOCK_EXPERTS.filter(expert => {
    const matchesSearch = expert.name.toLowerCase().includes(searchTerm.toLowerCase()) || 
                          expert.role.toLowerCase().includes(searchTerm.toLowerCase());
    const matchesIndustry = selectedIndustry ? expert.industry === selectedIndustry : true;
    return matchesSearch && matchesIndustry;
  });

  const openBookingModal = (expert) => {
    setSelectedExpert(expert);
    setBookingStep(1);
  };

  const closeModal = () => {
    setBookingStep(0);
    setTimeout(() => setSelectedExpert(null), 300);
  };

  const handleSimulatedPayment = (e) => {
    e.preventDefault();
    setBookingStep(2);
    setTimeout(() => setBookingStep(3), 1500); // Simulate processing
  };

  return (
    <div className="directory-container container">
      <div className="directory-header animate-fade-in">
        <h1>Find Your Expert</h1>
        <p>Book 1-on-1 consultations with verified veterans.</p>
      </div>

      <div className="directory-layout">
        {/* Sidebar Filters */}
        <aside className="filters-sidebar glass-panel animate-fade-in delay-100">
          <div className="filter-group">
            <h3 className="filter-title"><Search size={18}/> Search</h3>
            <input 
              type="text" 
              className="input-premium" 
              placeholder="Name or role..." 
              value={searchTerm}
              onChange={e => setSearchTerm(e.target.value)}
            />
          </div>
          <div className="filter-group">
            <h3 className="filter-title"><Filter size={18}/> Industry</h3>
            <select 
              className="input-premium select-premium"
              value={selectedIndustry}
              onChange={e => setSelectedIndustry(e.target.value)}
            >
              <option value="">All Industries</option>
              <option value="Education">Education</option>
              <option value="Banking & Finance">Banking & Finance</option>
              <option value="Engineering">Engineering</option>
              <option value="Corporate Leadership">Corporate Leadership</option>
            </select>
          </div>
        </aside>

        {/* Expert Grid */}
        <main className="experts-grid animate-fade-in delay-200">
          {filteredExperts.length === 0 ? (
            <div className="no-results">No experts found matching your criteria.</div>
          ) : (
            filteredExperts.map(expert => (
              <div key={expert.id} className="expert-card glass-panel">
                <div className="expert-header">
                  <div className="expert-avatar">{expert.img}</div>
                  <div className="expert-title">
                    <h3>{expert.name}</h3>
                    <p className="expert-role">{expert.role}</p>
                  </div>
                </div>
                <div className="expert-stats">
                  <div className="stat"><Clock size={16}/> {expert.exp} Yrs Exp</div>
                  <div className="stat"><Star size={16} color="var(--gold-accent)"/> {expert.rating}/5</div>
                </div>
                <div className="expert-footer">
                  <div className="expert-rate">₹{expert.rate} <span>/ hour</span></div>
                  <button className="btn-primary" onClick={() => openBookingModal(expert)}>
                    Book Session
                  </button>
                </div>
              </div>
            ))
          )}
        </main>
      </div>

      {/* Booking Modal Overlay */}
      {bookingStep > 0 && selectedExpert && (
        <div className="modal-overlay">
          <div className="modal-content glass-panel animate-fade-in">
            <button className="close-modal" onClick={closeModal}><X size={24}/></button>
            
            {bookingStep === 1 && (
              <div className="modal-step">
                <h2>Book Session with {selectedExpert.name}</h2>
                <p className="modal-subtitle">{selectedExpert.role}</p>
                
                <form onSubmit={handleSimulatedPayment} className="booking-form">
                  <div className="form-group">
                    <label>Select Date & Time</label>
                    <input type="datetime-local" className="input-premium" required />
                  </div>
                  <div className="form-group">
                    <label>Agenda (Brief)</label>
                    <textarea className="input-premium" rows="2" placeholder="What do you want to discuss?" required></textarea>
                  </div>
                  
                  <div className="price-summary">
                    <span>Consultation Fee (1 hr)</span>
                    <span>₹{selectedExpert.rate}</span>
                  </div>
                  
                  <button type="submit" className="btn-primary w-100 mt-2">
                    Proceed to Payment <ArrowRight size={18}/>
                  </button>
                </form>
              </div>
            )}

            {bookingStep === 2 && (
              <div className="modal-step text-center py-4">
                <div className="spinner"></div>
                <h2>Processing Payment...</h2>
                <p className="modal-subtitle">Simulating secure gateway for ₹{selectedExpert.rate}</p>
              </div>
            )}

            {bookingStep === 3 && (
              <div className="modal-step text-center py-4">
                <CheckCircle size={64} color="var(--success)" className="mx-auto mb-3" style={{ margin: '0 auto 16px' }}/>
                <h2>Booking Confirmed!</h2>
                <p className="modal-subtitle">Your session with {selectedExpert.name} is scheduled.</p>
                <div className="mt-4">
                  <button className="btn-primary w-100" onClick={closeModal}>Go to Dashboard</button>
                </div>
              </div>
            )}
          </div>
        </div>
      )}
    </div>
  );
};

export default ClientDirectory;
