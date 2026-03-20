import React from 'react';
import { Users, IndianRupee, Activity, CheckCircle, XCircle, TrendingUp } from 'lucide-react';
import './AdminDashboard.css';

const AdminDashboard = () => {
  return (
    <div className="admin-container container">
      <div className="admin-header animate-fade-in">
        <h1>Platform Overview</h1>
        <p>Monitor activity, verify experts, and manage the marketplace.</p>
      </div>

      <div className="stats-grid animate-fade-in delay-100">
        <div className="stat-card glass-panel flex-row">
          <div className="stat-icon"><Users size={28} /></div>
          <div className="stat-details">
            <h3>4,120</h3>
            <p>Total Experts</p>
          </div>
        </div>
        <div className="stat-card glass-panel flex-row">
          <div className="stat-icon bg-success"><CheckCircle size={28} /></div>
          <div className="stat-details">
            <h3>3,850</h3>
            <p>Verified</p>
          </div>
        </div>
        <div className="stat-card glass-panel flex-row">
          <div className="stat-icon bg-gold"><TrendingUp size={28} /></div>
          <div className="stat-details">
            <h3>1,200</h3>
            <p>Sessions This Month</p>
          </div>
        </div>
        <div className="stat-card glass-panel flex-row">
          <div className="stat-icon"><IndianRupee size={28} /></div>
          <div className="stat-details">
            <h3>₹2.4L</h3>
            <p>Platform Revenue</p>
          </div>
        </div>
      </div>

      <div className="admin-content-grid animate-fade-in delay-200">
        <section className="admin-section glass-panel">
          <h2 className="section-title">Pending Verifications</h2>
          <div className="table-responsive">
            <table className="admin-table">
              <thead>
                <tr>
                  <th>Name</th>
                  <th>Industry</th>
                  <th>Experience</th>
                  <th>Action</th>
                </tr>
              </thead>
              <tbody>
                <tr>
                  <td>Ramesh Gupta</td>
                  <td>Banking & Finance</td>
                  <td>Ex-HDFC Manager, 25 Yrs</td>
                  <td>
                    <div className="action-btns">
                      <button className="btn-icon success"><CheckCircle size={18}/></button>
                      <button className="btn-icon danger"><XCircle size={18}/></button>
                    </div>
                  </td>
                </tr>
                <tr>
                  <td>Priya Singh</td>
                  <td>Education</td>
                  <td>Former Dean, Delhi Univ.</td>
                  <td>
                    <div className="action-btns">
                      <button className="btn-icon success"><CheckCircle size={18}/></button>
                      <button className="btn-icon danger"><XCircle size={18}/></button>
                    </div>
                  </td>
                </tr>
              </tbody>
            </table>
          </div>
        </section>

        <section className="admin-section glass-panel">
          <h2 className="section-title">Recent Activity</h2>
          <div className="activity-list">
            <div className="activity-item">
              <div className="activity-icon"><Activity size={16}/></div>
              <div className="activity-text">
                <p><strong>Sunita Menon</strong> was booked by <strong>FinTech Solutions</strong></p>
                <span className="activity-time">2 hours ago</span>
              </div>
            </div>
            <div className="activity-item">
              <div className="activity-icon bg-success"><CheckCircle size={16}/></div>
              <div className="activity-text">
                <p><strong>Anand Sharma</strong> completed verification</p>
                <span className="activity-time">5 hours ago</span>
              </div>
            </div>
            <div className="activity-item">
              <div className="activity-icon"><Activity size={16}/></div>
              <div className="activity-text">
                <p><strong>Dr. Meena Iyer</strong> updated her hourly rate to ₹1500</p>
                <span className="activity-time">1 day ago</span>
              </div>
            </div>
          </div>
        </section>
      </div>
    </div>
  );
};

export default AdminDashboard;
