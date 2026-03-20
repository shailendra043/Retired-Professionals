import React from 'react';
import { Routes, Route } from 'react-router-dom';
import Layout from './components/Layout';
import LandingPage from './pages/LandingPage';
import ProfessionalOnboarding from './pages/ProfessionalOnboarding';
import ClientDirectory from './pages/ClientDirectory';
import AdminDashboard from './pages/AdminDashboard';

function App() {
  return (
    <Routes>
      <Route path="/" element={<Layout />}>
        <Route index element={<LandingPage />} />
        <Route path="professionals/join" element={<ProfessionalOnboarding />} />
        <Route path="directory" element={<ClientDirectory />} />
        <Route path="admin" element={<AdminDashboard />} />
      </Route>
    </Routes>
  );
}

export default App;
