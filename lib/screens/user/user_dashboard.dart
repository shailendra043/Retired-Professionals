import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../state/app_state.dart';

class UserDashboard extends StatefulWidget {
  const UserDashboard({super.key});

  @override
  State<UserDashboard> createState() => _UserDashboardState();
}

class _UserDashboardState extends State<UserDashboard> {
  int _tabIndex = 0;
  final TextEditingController _postController = TextEditingController();

  @override
  void dispose() {
    _postController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = AppScope.of(context);
    final profile = state.currentProfessional;

    if (profile == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Professional Dashboard')),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.person_add_alt_1, size: 56),
                const SizedBox(height: 12),
                const Text('Set up your profile to continue.'),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => context.go('/professional/setup'),
                  child: const Text('Complete Profile'),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Professional Network'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => context.go('/login'),
          ),
        ],
      ),
      body: IndexedStack(
        index: _tabIndex,
        children: [
          _homeTab(context, state, profile),
          _networkTab(state),
          _opportunitiesTab(profile),
          _messagesTab(),
          _profileTab(context, profile),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _tabIndex,
        onDestinationSelected: (index) => setState(() => _tabIndex = index),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.people_outline), label: 'My Network'),
          NavigationDestination(icon: Icon(Icons.work_outline), label: 'Opportunities'),
          NavigationDestination(icon: Icon(Icons.chat_bubble_outline), label: 'Messages'),
          NavigationDestination(icon: Icon(Icons.person_outline), label: 'Profile'),
        ],
      ),
    );
  }

  Widget _homeTab(BuildContext context, AppState state, ProfessionalProfile profile) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Share an update', style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 10),
                TextField(
                  controller: _postController,
                  minLines: 2,
                  maxLines: 4,
                  decoration: const InputDecoration(
                    hintText: 'What insight would you like to share today?',
                  ),
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: () {
                      state.createPost(_postController.text);
                      _postController.clear();
                    },
                    child: const Text('Post'),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),
        if (state.feedPosts.isEmpty)
          const Card(
            child: Padding(
              padding: EdgeInsets.all(18),
              child: Text('No posts yet. Start your professional feed by sharing your first update.'),
            ),
          )
        else
          ...state.feedPosts.map(
            (post) => Card(
              child: ListTile(
                title: Text(post.authorName),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(post.content),
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _networkTab(AppState state) {
    final professionals = state.professionals;
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _statCard('Connections', '${professionals.isEmpty ? 0 : 1}', Icons.people),
        const SizedBox(height: 10),
        const Card(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Text('As more professionals join, this section will show connection requests and recommendations.'),
          ),
        ),
      ],
    );
  }

  Widget _opportunitiesTab(ProfessionalProfile profile) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _statCard('Open to work', profile.availability, Icons.work_history),
        const SizedBox(height: 10),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Your listed services', style: TextStyle(fontWeight: FontWeight.w700)),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: profile.services.map((s) => Chip(label: Text(s))).toList(),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _messagesTab() {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Text('No messages yet.'),
      ),
    );
  }

  Widget _profileTab(BuildContext context, ProfessionalProfile profile) {
    final verification = [
      if (profile.idVerified) 'ID Verified',
      if (profile.employmentVerified) 'Employment Verified',
    ];

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(profile.fullName, style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 4),
                Text(profile.designation),
                const SizedBox(height: 8),
                Text('${profile.industry} • ${profile.yearsOfExperience} years experience'),
                const SizedBox(height: 8),
                Text(profile.summary),
                const SizedBox(height: 10),
                Text('₹${profile.hourlyRate}/hour'),
                const SizedBox(height: 10),
                Text(verification.isEmpty ? 'Verification pending' : verification.join(' • ')),
                const SizedBox(height: 14),
                OutlinedButton.icon(
                  onPressed: () => context.go('/professional/setup'),
                  icon: const Icon(Icons.edit),
                  label: const Text('Edit Profile'),
                ),
              ],
            ),
          ),
        ),
      ],
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
