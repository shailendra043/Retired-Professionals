import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { ArrowRight, CheckCircle } from 'lucide-react';
import './ProfessionalOnboarding.css';

const ProfessionalOnboarding = () => {
  const navigate = useNavigate();
  const [step, setStep] = useState(1);
  const [formData, setFormData] = useState({
    phone: '',
    otp: '',
    name: '',
    industry: '',
    experience: '',
    hourlyRate: ''
  });

  const handleChange = (e) => setFormData({...formData, [e.target.name]: e.target.value});

  const generateOTP = (e) => {
    e.preventDefault();
    setStep(2);
  };

  const verifyOTP = (e) => {
    e.preventDefault();
    setStep(3);
  };

  const submitProfile = (e) => {
    e.preventDefault();
    setStep(4);
  };

  const finalizeOnboarding = (e) => {
    e.preventDefault();
    setStep(5);
    setTimeout(() => {
      navigate('/admin'); // Simulate redirecting to admin dashboard
    }, 2000);
  };

  return (
    <div className="onboarding-container container">
      <div className="glass-panel onboarding-card animate-fade-in">
        
        {step === 1 && (
          <form onSubmit={generateOTP} className="onboarding-form">
            <h2 className="large-title">Welcome to SilverPro</h2>
            <p className="large-subtitle">Let's get started. Please enter your mobile number.</p>
            
            <div className="form-group">
              <label>Mobile Number</label>
              <div className="phone-input-wrapper">
                <span className="country-code">+91</span>
                <input 
                  type="tel" 
                  name="phone"
                  className="input-premium large-input"
                  placeholder="98765 43210" 
                  value={formData.phone}
                  onChange={handleChange}
                  required
                />
              </div>
            </div>
            
            <button type="submit" className="btn-primary w-100 large-btn">
              Get OTP <ArrowRight />
            </button>
          </form>
        )}

        {step === 2 && (
          <form onSubmit={verifyOTP} className="onboarding-form animate-fade-in">
            <h2 className="large-title">Verify Your Number</h2>
            <p className="large-subtitle">We sent a 4-digit code to {formData.phone || 'your phone'}</p>
            
            <div className="form-group">
              <label>Enter OTP</label>
              <input 
                type="text" 
                name="otp"
                className="input-premium large-input text-center"
                placeholder="• • • •" 
                maxLength="4"
                value={formData.otp}
                onChange={handleChange}
                required
              />
            </div>
            <p className="helper-text">Simulation: Just type any 4 digits and proceed.</p>
            
            <button type="submit" className="btn-primary w-100 large-btn">
              Verify <CheckCircle />
            </button>
          </form>
        )}

        {step === 3 && (
          <form onSubmit={submitProfile} className="onboarding-form animate-fade-in">
            <h2 className="large-title">Profile Details</h2>
            <p className="large-subtitle">Tell us about your extensive experience.</p>
            
            <div className="form-group">
              <label>Full Name</label>
              <input 
                type="text" 
                name="name"
                className="input-premium large-input"
                placeholder="e.g. Anand Sharma"
                value={formData.name}
                onChange={handleChange}
                required
              />
            </div>

            <div className="form-group">
              <label>Primary Industry</label>
              <select 
                name="industry" 
                className="input-premium large-input select-premium"
                value={formData.industry}
                onChange={handleChange}
                required
              >
                <option value="">Select Industry...</option>
                <option value="education">Education & Teaching</option>
                <option value="finance">Banking & Finance</option>
                <option value="corporate">Corporate Leadership</option>
                <option value="engineering">Engineering</option>
                <option value="healthcare">Healthcare</option>
              </select>
            </div>

            <div className="form-group">
              <label>Experience Summary (Brief)</label>
              <textarea 
                name="experience"
                className="input-premium large-input"
                rows="3"
                placeholder="E.g. 30 years ex-SBI Manager. Expertise in commercial loans."
                value={formData.experience}
                onChange={handleChange}
                required
              ></textarea>
            </div>
            
            <button type="submit" className="btn-primary w-100 large-btn">
              Next Step <ArrowRight />
            </button>
          </form>
        )}

        {step === 4 && (
          <form onSubmit={finalizeOnboarding} className="onboarding-form animate-fade-in">
            <h2 className="large-title">Services & Rates</h2>
            <p className="large-subtitle">Set your hourly consultation fee.</p>
            
            <div className="form-group">
              <label>Hourly Rate (₹)</label>
              <input 
                type="number" 
                name="hourlyRate"
                className="input-premium large-input"
                placeholder="e.g. 1000"
                value={formData.hourlyRate}
                onChange={handleChange}
                required
              />
              <p className="helper-text">Platform commission is 20%. You earn 80% per booking.</p>
            </div>

            <button type="submit" className="btn-primary w-100 large-btn">
              Complete Profile <CheckCircle />
            </button>
          </form>
        )}

        {step === 5 && (
          <div className="success-state animate-fade-in">
            <CheckCircle size={80} color="var(--success)" />
            <h2 className="large-title">Profile Created!</h2>
            <p className="large-subtitle">Redirecting to your dashboard...</p>
          </div>
        )}

      </div>
    </div>
  );
};

export default ProfessionalOnboarding;
