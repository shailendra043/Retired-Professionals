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

Two GitHub Actions workflows are configured:

1. **CI** ([.github/workflows/ci.yml](.github/workflows/ci.yml))
	- Runs on push/PR
	- Flutter: `pub get`, `analyze`, `test`, `build web`
	- Admin dashboard: `lint`, `build`

2. **CD (GitHub Pages)** ([.github/workflows/deploy_flutter_web.yml](.github/workflows/deploy_flutter_web.yml))
	- Deploys Flutter Web on push to `main`
	- Uses GitHub Pages Actions deployment

## GitHub Pages Setup (one-time)

- In repository settings, go to **Pages**.
- Set **Source** to **GitHub Actions**.
