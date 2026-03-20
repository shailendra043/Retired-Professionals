# Retired Professionals Platform

Flutter marketplace MVP for connecting retired professionals with students and companies.

## Local Development

### Flutter app
- Install dependencies: `flutter pub get`
- Run app: `flutter run`
- Analyze: `flutter analyze`
- Test: `flutter test`

### Admin dashboard
- `cd admin_dashboard`
- Install dependencies: `npm ci`
- Lint: `npm run lint`
- Build: `npm run build`

## CI/CD

GitHub Actions workflows configured:

1. **CI** ([.github/workflows/ci.yml](.github/workflows/ci.yml))
	- Runs on push/PR.
	- Flutter Android job: `pub get`, `analyze`, `test`, `build apk --release`.
	- Flutter iOS job: `pub get`, `build ios --release --no-codesign`.
	- Uploads artifacts: Android APK and iOS `Runner.app`.
	- Admin dashboard: `lint`, `build`.

2. **Disabled deploy workflow** ([.github/workflows/deploy_flutter_web.yml](.github/workflows/deploy_flutter_web.yml))
	- GitHub Pages deployment is intentionally disabled.
