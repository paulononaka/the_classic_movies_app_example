# The Classic Movies App

The "good old" example app with movies, good code, and Flutter magic.

### File Structure

```
the_classic_movies_app_example/
├── apps/
│   └── main_app/            # Main Flutter app entry point
├── packages/
│   ├── core/                # Core utilities, services, and shared logic
│   ├── design_system/       # UI components, themes, and design tokens
│   └── movies/              # Movies feature module (data, domain, presentation)
├── .env.example             # Example environment variables
├── melos.yaml               # Melos workspace configuration
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

## Libraries

- **Navigation**: go_router
- **Dependency Injection**: get_it
- **Internationalization**: intl
- **Persistence**: hive, hive_flutter
- **Dev Tools**: melos, fvm
- **Testing**: flutter_test, golden_toolkit
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

### Environment Variables

This project uses environment variables for configuration. To set them up:

1. Copy the `.env.example` file to create a `.env` file:
   ```bash
   cp .env.example .env
   ```
2. Edit the `.env` file and replace `your_tmdb_api_key` with your actual TMDB API key

The following environment variables are used:
- `TMDB_API_KEY`: Your TMDB API key for authentication
- `TMDB_BASE_URL`: Base URL for TMDB API requests (default: https://api.themoviedb.org/3)
- `TMDB_IMAGE_URL`: Base URL for TMDB image requests (default: https://image.tmdb.org/t/p/)
- `SENTRY_DSN`: Your Sentry DSN for error tracking and monitoring