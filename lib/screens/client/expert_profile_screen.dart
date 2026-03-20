import 'package:flutter/material.dart';
import '../../state/app_state.dart';

class ExpertProfileScreen extends StatelessWidget {
  final String expertId;

  const ExpertProfileScreen({super.key, required this.expertId});

  @override
  Widget build(BuildContext context) {
    final profiles = AppScope.of(context).professionals;
    final match = profiles.where((e) => e.id == expertId);
    final expert = match.isEmpty ? null : match.first;
    if (expert == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Expert Profile')),
        body: const Center(child: Text('Expert not found.')),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Expert Profile')),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(expert.fullName, style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 6),
                  Text(expert.designation),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      Chip(label: Text('${expert.yearsOfExperience} years experience')),
                      Chip(label: Text('₹${expert.hourlyRate}/hour')),
                      Chip(label: Text(expert.industry)),
                      Chip(
                        label: Text(
                          expert.idVerified && expert.employmentVerified
                              ? 'Verified'
                              : 'Verification Pending',
                        ),
                        avatar: Icon(
                          expert.idVerified && expert.employmentVerified ? Icons.verified : Icons.info,
                          size: 16,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Text(expert.summary),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Services',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 10),
                  ...expert.services.map((s) => ListTile(
                        dense: true,
                        leading: const Icon(Icons.check_circle_outline),
                        title: Text(s),
                      )),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Card(
            child: ListTile(
              leading: const Icon(Icons.star, color: Colors.amber),
              title: Text('Availability: ${expert.availability}'),
              subtitle: const Text('Ratings will appear after real bookings.'),
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Session request submitted (MVP mock).')),
              );
            },
            icon: const Icon(Icons.calendar_month),
            label: const Text('Book Consultation'),
          ),
        ],
      ),
    );
  }
}
