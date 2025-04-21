# The Classic Movies App

The "good old" example app with movies, good code, and Flutter magic.

### File Structure

```
the_classic_movies_app_example/
├── android/                 # Android platform-specific code
├── ios/                     # iOS platform-specific code
├── lib/                     # Main Flutter app entry point
│   └── l10n/                # Localization resources
├── modules/
│   ├── core/                # Core utilities, services, and shared logic
│   │   └── lib/
│   │       ├── exceptions/  # Custom exception handling
│   │       ├── extensions/  # Dart extensions
│   │       ├── l10n/        # Localization resources
│   │       ├── logger/      # Logging functionality
│   │       └── services/    # Core services (feature toggles, Sentry, session tracking)
│   ├── design_system/       # UI components, themes, and design tokens
│   │   └── lib/
│   │       ├── components/  # Reusable UI components
│   │       ├── l10n/        # Localization resources
│   │       └── theme/       # App theming and styling
│   └── movies/              # Movies feature module (data, domain, presentation)
│       ├── lib/
│       │   ├── data/        # Data layer (data sources, repositories implementations)
│       │   ├── domain/      # Domain layer (interfaces, business logic)
│       │   ├── infrastructure/ # Infrastructure setup (dependencies, services)
│       │   ├── l10n/        # Localization resources
│       │   ├── pages/       # UI screens and controllers
│       │   └── routes/      # Navigation routes
│       └── test/            # Module-specific tests
├── test/                    # Test directory
│   ├── e2e/                 # End-to-end tests
│   └── helpers/             # Test helpers
├── web/                     # Web platform-specific code
├── pubspec.yaml             # Project dependencies
└── README.md
```

## Architecture

This project follows a modular, scalable architecture:

- **Feature Modules**: Each feature (e.g., movies) is isolated in its own package for separation of concerns and reusability.
- **Core Module**: Contains shared logic, services (e.g., networking, storage), and utilities.
- **Design System**: Centralizes UI components and theming for consistency.
- **Dependency Injection**: Managed via `get_it`.
- **Navigation**: Handled by `go_router`.
- **Persistence**: Local storage is managed using [Hive](https://docs.hivedb.dev/).
- **Error Monitoring**: Application errors and crashes are tracked using [Sentry](https://sentry.io).

For a more detailed technical analysis, check the [Technical Notes](docs/Technical_Notes.md) and the [Architecture Diagram](docs/diagram.png) for a comprehensive overview of the implementation.

## Libraries

- **Navigation**: go_router
- **Dependency Injection**: get_it
- **Internationalization**: intl
- **Persistence**: hive, hive_flutter
- **Dev Tools**: melos, fvm
- **Testing**: flutter_test, golden_toolkit, mocktail
- **Error Monitoring**: sentry_flutter

## Development Setup

### Flutter

This project uses Flutter 3.29.3. It's recommended to use FVM (Flutter Version Management) to ensure you're using the correct Flutter version:

```bash
# Install FVM if you don't have it
dart pub global activate fvm

# Get the correct Flutter version
fvm install

# Use this version
fvm use 3.29.3
```

### Melos

[Melos](https://melos.invertase.dev/) is used for managing the monorepo.

```bash
# Install Melos
dart pub global activate melos

# Bootstrap the project (install all dependencies)
melos bootstrap

# Run all tests in all packages
melos tests

# Run only unit test for the selected package
melos test:ask

# Generate code (used by Hive adapters)
melos gen
```

### Running the App

```bash
# Using FVM
fvm flutter run
```

### Testing

The project includes several types of tests:

```bash
# Run all tests in all packages
melos tests

# Run only unit test for the selected package
melos test:ask
```

#### Unit Tests
Unit tests verify the behavior of individual components in isolation.

#### Golden Tests
Golden tests validate UI components, their interactions and compare rendered widgets against reference images to detect visual regressions.

#### E2E Tests
End-to-End tests validate complete user flows through the application:
- Happy path flows (browsing movies, viewing details, navigating between screens)
- Error handling scenarios (network errors, retry mechanisms)

E2E tests use mocked repositories to simulate different scenarios without requiring actual API calls.

### Environment Variables

This project uses Dart define for environment variables. Environment variables are passed at build/run time:

```bash
flutter run --dart-define=TMDB_API_KEY=your_tmdb_api_key
```

For VS Code users, the launch configuration in `.vscode/launch.json` already includes all necessary environment variables.

For command line usage, you can create a `.env.sh` script to run the app with all environment variables:

```bash
#!/bin/bash
flutter run \
  --dart-define=TMDB_API_KEY=your_tmdb_api_key \
  --dart-define=TMDB_BASE_URL=https://api.themoviedb.org/3 \
  --dart-define=TMDB_IMAGE_URL=https://image.tmdb.org/t/p/ \
  # Add other environment variables as needed
```

The following environment variables are used:
- `TMDB_API_KEY`: Your TMDB API key for authentication
- `TMDB_BASE_URL`: Base URL for TMDB API requests (default: https://api.themoviedb.org/3)
- `TMDB_IMAGE_URL`: Base URL for TMDB image requests (default: https://image.tmdb.org/t/p/)
- `SENTRY_DSN`: Your Sentry DSN for error tracking and monitoring
- `FIREBASE_WEB_API_KEY`: Your Firebase Web API key
- `FIREBASE_WEB_APP_ID`: Your Firebase Web App ID
- `FIREBASE_AUTH_DOMAIN`: Your Firebase Auth Domain
- `FIREBASE_MEASUREMENT_ID`: Your Firebase Measurement ID
- `FIREBASE_ANDROID_API_KEY`: Your Firebase Android API key
- `FIREBASE_ANDROID_APP_ID`: Your Firebase Android App ID
- `FIREBASE_IOS_API_KEY`: Your Firebase iOS API key
- `FIREBASE_IOS_APP_ID`: Your Firebase iOS App ID
- `FIREBASE_IOS_BUNDLE_ID`: Your iOS Bundle ID
- `FIREBASE_PROJECT_ID`: Your Firebase Project ID (used for web deployment)
- `FIREBASE_MESSAGING_SENDER_ID`: Your Firebase Messaging Sender ID
- `FIREBASE_STORAGE_BUCKET`: Your Firebase Storage Bucket
- `FIREBASE_SERVICE_ACCOUNT`: Your Firebase Service Account for GitHub Actions deployment

### Firebase Configuration

This project uses Firebase for various features. To set up Firebase:

1. Create a Firebase project at [Firebase Console](https://console.firebase.google.com/)
2. Add Android and iOS apps to your Firebase project
3. Download the configuration files:
   - `google-services.json` for Android
   - `GoogleService-Info.plist` for iOS
4. Place these files in their respective directories:
   - Android: `android/app/google-services.json`
   - iOS: `ios/Runner/GoogleService-Info.plist`
5. Create a `firebase.json` file in the project root with your Firebase configuration
6. Create a copy of `lib/firebase_options.dart.template` as `lib/firebase_options.dart` and replace the placeholder values with your Firebase configuration

### GitHub Actions CI/CD

This project uses GitHub Actions for CI/CD. To set up the required secrets for the pipeline:

1. Go to your GitHub repository settings
2. Navigate to Secrets and Variables > Actions
3. Add the following secrets:
   - `TMDB_API_KEY`: Your TMDB API key
   - `TMDB_BASE_URL`: Base URL for TMDB API (e.g., https://api.themoviedb.org/3)
   - `TMDB_IMAGE_URL`: Base URL for TMDB images (e.g., https://image.tmdb.org/t/p/)
   - `GOOGLE_SERVICES_JSON`: The entire content of your `google-services.json` file (base64 encoded)
   - `GOOGLE_SERVICE_INFO_PLIST`: The entire content of your `GoogleService-Info.plist` file (base64 encoded)
   - `FIREBASE_JSON`: The entire content of your `firebase.json` file (base64 encoded)
   - `FIREBASE_WEB_API_KEY`: Your Firebase Web API key
   - `FIREBASE_WEB_APP_ID`: Your Firebase Web App ID
   - `FIREBASE_ANDROID_API_KEY`: Your Firebase Android API key
   - `FIREBASE_ANDROID_APP_ID`: Your Firebase Android App ID
   - `FIREBASE_IOS_API_KEY`: Your Firebase iOS API key
   - `FIREBASE_IOS_APP_ID`: Your Firebase iOS App ID
   - `FIREBASE_IOS_BUNDLE_ID`: Your iOS Bundle ID
   - `FIREBASE_MESSAGING_SENDER_ID`: Your Firebase Messaging Sender ID
   - `FIREBASE_PROJECT_ID`: Your Firebase Project ID
   - `FIREBASE_STORAGE_BUCKET`: Your Firebase Storage Bucket
   - `FIREBASE_AUTH_DOMAIN`: Your Firebase Auth Domain
   - `FIREBASE_MEASUREMENT_ID`: Your Firebase Measurement ID

To encode your Firebase configuration files as base64:

```bash
# For Android
base64 -i android/app/google-services.json | pbcopy

# For iOS
base64 -i ios/Runner/GoogleService-Info.plist | pbcopy

# For firebase.json
base64 -i firebase.json | pbcopy
```

This will copy the base64-encoded content to your clipboard, which you can then paste as the value for the corresponding GitHub Secret.