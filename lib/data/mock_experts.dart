class Expert {
  final String id;
  final String name;
  final String title;
  final String industry;
  final int yearsOfExperience;
  final String location;
  final String language;
  final List<String> services;
  final int hourlyRate;
  final bool verified;
  final double rating;
  final int sessions;
  final String bio;

  const Expert({
    required this.id,
    required this.name,
    required this.title,
    required this.industry,
    required this.yearsOfExperience,
    required this.location,
    required this.language,
    required this.services,
    required this.hourlyRate,
    required this.verified,
    required this.rating,
    required this.sessions,
    required this.bio,
  });
}

const List<Expert> experts = [
  Expert(
    id: 'e1',
    name: 'Dr. Meera Iyer',
    title: 'Retired Principal & Physics Educator',
    industry: 'Education',
    yearsOfExperience: 34,
    location: 'Bengaluru',
    language: 'English, Hindi',
    services: ['Mentoring', 'Career Guidance', 'Subject Coaching'],
    hourlyRate: 1200,
    verified: true,
    rating: 4.9,
    sessions: 312,
    bio:
        'Helped 3,000+ students with board preparation and STEM career planning. Focus on confidence and clear fundamentals.',
  ),
  Expert(
    id: 'e2',
    name: 'Anil Sharma',
    title: 'Ex-CBSE Mathematics HOD',
    industry: 'Education',
    yearsOfExperience: 29,
    location: 'Jaipur',
    language: 'Hindi, English',
    services: ['Mentoring', 'Exam Strategy', 'Online Tuition'],
    hourlyRate: 900,
    verified: true,
    rating: 4.8,
    sessions: 228,
    bio:
        'Specialist in board exam score improvement and practical revision plans for classes 9-12.',
  ),
  Expert(
    id: 'e3',
    name: 'Nandita Rao',
    title: 'Retired English Professor',
    industry: 'Education',
    yearsOfExperience: 31,
    location: 'Pune',
    language: 'English',
    services: ['Communication Coaching', 'Mentoring', 'Interview Prep'],
    hourlyRate: 1500,
    verified: false,
    rating: 4.7,
    sessions: 140,
    bio:
        'Supports college students and early professionals with communication, writing and interview confidence.',
  ),
];
