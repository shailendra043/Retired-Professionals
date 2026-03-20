import 'package:flutter/material.dart';

class ProfessionalProfile {
  final String id;
  final String fullName;
  final String designation;
  final String industry;
  final int yearsOfExperience;
  final String summary;
  final String availability;
  final List<String> services;
  final int hourlyRate;
  final bool idVerified;
  final bool employmentVerified;

  const ProfessionalProfile({
    required this.id,
    required this.fullName,
    required this.designation,
    required this.industry,
    required this.yearsOfExperience,
    required this.summary,
    required this.availability,
    required this.services,
    required this.hourlyRate,
    required this.idVerified,
    required this.employmentVerified,
  });
}

class FeedPost {
  final String id;
  final String authorName;
  final String content;
  final DateTime createdAt;

  const FeedPost({
    required this.id,
    required this.authorName,
    required this.content,
    required this.createdAt,
  });
}

class AppState extends ChangeNotifier {
  ProfessionalProfile? _currentProfessional;
  final List<FeedPost> _feedPosts = [];

  ProfessionalProfile? get currentProfessional => _currentProfessional;
  List<FeedPost> get feedPosts => List.unmodifiable(_feedPosts);

  List<ProfessionalProfile> get professionals {
    if (_currentProfessional == null) {
      return const [];
    }
    return [_currentProfessional!];
  }

  void saveProfessionalProfile(ProfessionalProfile profile) {
    _currentProfessional = profile;
    notifyListeners();
  }

  void createPost(String content) {
    final profile = _currentProfessional;
    if (profile == null || content.trim().isEmpty) {
      return;
    }
    _feedPosts.insert(
      0,
      FeedPost(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        authorName: profile.fullName,
        content: content.trim(),
        createdAt: DateTime.now(),
      ),
    );
    notifyListeners();
  }
}

class AppScope extends InheritedNotifier<AppState> {
  const AppScope({
    super.key,
    required AppState state,
    required super.child,
  }) : super(notifier: state);

  static AppState of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<AppScope>();
    assert(scope != null, 'AppScope not found in widget tree');
    return scope!.notifier!;
  }
}
