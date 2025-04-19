# The Classic Movies App

A Flutter application for classic movies.

## Project Structure

- **Main App**: Root application that integrates all modules
- **Modules**:
  - `movies`: Movies feature module
  - `core`: Core utilities and shared functionality
  - `design_system`: UI components and theming

## Libraries

- **Navigation**: go_router
- **Dependency Injection**: get_it
- **Internationalization**: intl
- **Dev Tools**: melos, fvm
- **Testing**: flutter_test, golden_toolkit

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

```bash
# Install Melos
dart pub global activate melos

# Bootstrap the project
melos bootstrap
```

### Running the App

```bash
# Using FVM
fvm flutter run