import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../widgets/custom_button.dart';

class ProfileSetupScreen extends StatefulWidget {
  const ProfileSetupScreen({super.key});

  @override
  State<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _designationController = TextEditingController();
  final _experienceController = TextEditingController();
  final _summaryController = TextEditingController();
  final _rateController = TextEditingController();

  String _selectedIndustry = 'Education';
  String _selectedAvailability = '5 hrs/week';
  String _selectedService = 'Mentoring';

  bool _idVerified = false;
  bool _employmentVerified = false;

  final List<String> _industries = [
    'Education',
    'Finance & Banking',
    'Engineering',
    'HR & Management',
    'Defense',
    'IT/Tech'
  ];

  final List<String> _services = [
    'Mentoring',
    'Consulting',
    'Advisory',
    'Teaching',
  ];

  final List<String> _availability = [
    '3 hrs/week',
    '5 hrs/week',
    '10 hrs/week',
    '15 hrs/week',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _designationController.dispose();
    _experienceController.dispose();
    _summaryController.dispose();
    _rateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Setup Profile'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Complete your profile',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Full Name'),
                validator: (value) => value!.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                initialValue: _selectedIndustry,
                decoration: const InputDecoration(labelText: 'Industry/Domain'),
                items: _industries.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _selectedIndustry = newValue!;
                  });
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _experienceController,
                decoration: const InputDecoration(labelText: 'Years of Experience'),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _designationController,
                decoration: const InputDecoration(labelText: 'Previous Designation (e.g. AGM, Principal)'),
                validator: (value) => value!.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                initialValue: _selectedService,
                decoration: const InputDecoration(labelText: 'Primary Service'),
                items: _services
                    .map((value) => DropdownMenuItem(value: value, child: Text(value)))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedService = value ?? 'Mentoring';
                  });
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                initialValue: _selectedAvailability,
                decoration: const InputDecoration(labelText: 'Availability'),
                items: _availability
                    .map((value) => DropdownMenuItem(value: value, child: Text(value)))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedAvailability = value ?? '5 hrs/week';
                  });
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _summaryController,
                maxLines: 4,
                decoration: const InputDecoration(
                  labelText: 'Experience Summary (Brief)',
                  alignLabelWithHint: true,
                ),
                validator: (value) => value!.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _rateController,
                decoration: const InputDecoration(labelText: 'Hourly Rate / Fee (₹)'),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 8),
              CheckboxListTile(
                value: _idVerified,
                onChanged: (v) => setState(() => _idVerified = v ?? false),
                title: const Text('ID proof uploaded'),
                contentPadding: EdgeInsets.zero,
              ),
              CheckboxListTile(
                value: _employmentVerified,
                onChanged: (v) => setState(() => _employmentVerified = v ?? false),
                title: const Text('Employment proof uploaded'),
                contentPadding: EdgeInsets.zero,
              ),
              const SizedBox(height: 32),
              CustomButton(
                text: 'Save & Go to Dashboard',
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    context.go('/professional/dashboard');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
