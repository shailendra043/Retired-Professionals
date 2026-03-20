import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class UserDashboard extends StatelessWidget {
  const UserDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => context.go('/login'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Profile Summary Card
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.grey,
                      child: Icon(Icons.person, size: 50, color: Colors.white),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Rakesh Sharma',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Retired Teacher | 30 Yrs Experience',
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    OutlinedButton.icon(
                      onPressed: () => context.go('/professional/setup'),
                      icon: const Icon(Icons.edit),
                      label: const Text('Edit Profile'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _statCard('This Month Sessions', '12', Icons.calendar_month),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _statCard('Estimated Earnings', '₹10,800', Icons.payments),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Card(
              child: ListTile(
                leading: const Icon(Icons.verified_user, color: Colors.green),
                title: const Text('Trust & Verification'),
                subtitle: const Text('ID Verified • Employment Verified • Onboarding Call Done'),
              ),
            ),
            const SizedBox(height: 32),
            Text(
              'Recent Booking Requests',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            // Mock Requests
            _buildRequestCard(
              context,
              clientName: 'Parent Group - Bengaluru',
              projectType: 'Class 10 Physics Mentoring',
              duration: '1 Hour Session',
              status: 'Pending',
            ),
            _buildRequestCard(
              context,
              clientName: 'STEM Juniors Academy',
              projectType: 'Career Guidance Workshop',
              duration: '2 Hour Session',
              status: 'Confirmed',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRequestCard(
    BuildContext context, {
    required String clientName,
    required String projectType,
    required String duration,
    required String status,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        title: Text(clientName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Text('Requirement: $projectType'),
            Text('Duration: $duration'),
          ],
        ),
        trailing: Chip(
          label: Text(
            status,
            style: TextStyle(
              color: status == 'Pending' ? Colors.orange.shade900 : Colors.green.shade900,
            ),
          ),
          backgroundColor: status == 'Pending' ? Colors.orange.shade100 : Colors.green.shade100,
        ),
      ),
    );
  }

  Widget _statCard(String label, String value, IconData icon) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon),
            const SizedBox(height: 8),
            Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
            const SizedBox(height: 2),
            Text(label),
          ],
        ),
      ),
    );
  }
}
