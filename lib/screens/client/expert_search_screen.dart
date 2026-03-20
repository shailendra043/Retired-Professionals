import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../state/app_state.dart';

class ExpertSearchScreen extends StatefulWidget {
  const ExpertSearchScreen({super.key});

  @override
  State<ExpertSearchScreen> createState() => _ExpertSearchScreenState();
}

class _ExpertSearchScreenState extends State<ExpertSearchScreen> {
  double _maxRate = 2000;
  bool _verifiedOnly = false;
  String _location = 'All';
  String _language = 'All';
  int _minExperience = 0;

  List<ProfessionalProfile> _filteredExperts(List<ProfessionalProfile> profiles) {
    return profiles.where((expert) {
      final rateOk = expert.hourlyRate <= _maxRate;
      final verifiedOk = !_verifiedOnly || (expert.idVerified && expert.employmentVerified);
      final locationOk = true;
      final languageOk = true;
      final expOk = expert.yearsOfExperience >= _minExperience;
      return rateOk && verifiedOk && locationOk && languageOk && expOk;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final appState = AppScope.of(context);
    final allProfiles = appState.professionals;
    final visibleProfiles = _filteredExperts(allProfiles);

    final locations = ['All'];
    final languages = ['All', 'English', 'Hindi'];

    return Scaffold(
      appBar: AppBar(title: const Text('Search Experts')),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Filters',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Expanded(child: Text('Minimum Experience')),
                      DropdownButton<int>(
                        value: _minExperience,
                        items: const [0, 10, 20, 25, 30]
                            .map((v) => DropdownMenuItem(value: v, child: Text('$v+ yrs')))
                            .toList(),
                        onChanged: (value) => setState(() => _minExperience = value ?? 0),
                      ),
                    ],
                  ),
                  DropdownButtonFormField<String>(
                    initialValue: _location,
                    decoration: const InputDecoration(labelText: 'Location'),
                    items: locations
                        .map((v) => DropdownMenuItem(value: v, child: Text(v)))
                        .toList(),
                    onChanged: (value) => setState(() => _location = value ?? 'All'),
                  ),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    initialValue: _language,
                    decoration: const InputDecoration(labelText: 'Language'),
                    items: languages
                        .map((v) => DropdownMenuItem(value: v, child: Text(v)))
                        .toList(),
                    onChanged: (value) => setState(() => _language = value ?? 'All'),
                  ),
                  const SizedBox(height: 12),
                  Text('Max Hourly Rate: ₹${_maxRate.toInt()}'),
                  Slider(
                    min: 500,
                    max: 2500,
                    divisions: 20,
                    value: _maxRate,
                    onChanged: (value) => setState(() => _maxRate = value),
                  ),
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    value: _verifiedOnly,
                    onChanged: (value) => setState(() => _verifiedOnly = value),
                    title: const Text('Verified experts only'),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 14),
          Text(
            '${visibleProfiles.length} professionals found',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          if (visibleProfiles.isEmpty)
            const Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Text('No profiles available yet. Ask a professional to complete onboarding first.'),
              ),
            )
          else
            ...visibleProfiles.map(
            (expert) => Card(
              child: ListTile(
                contentPadding: const EdgeInsets.all(14),
                title: Text(expert.fullName),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Text(
                    '${expert.designation}\n${expert.yearsOfExperience} yrs • ₹${expert.hourlyRate}/hr',
                  ),
                ),
                trailing: const Icon(Icons.arrow_forward_ios, size: 18),
                onTap: () => context.go('/client/expert/${expert.id}'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
