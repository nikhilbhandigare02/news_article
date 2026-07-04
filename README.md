# Flutter Application

## Setup & Run

### Prerequisites
- Flutter SDK
- Dart SDK
- Android Studio or VS Code
- Android Emulator or Physical Device

### Installation

```bash
flutter pub get
```

### Run the App

```bash
flutter run
```

## Architecture

This project follows the **MVVM architecture** using **BLoC** for state management and the **Repository Pattern** for data handling.

- **BLoC:** Separates the UI from the business logic by managing application state through events and states, making the application more maintainable and testable.
- **Repository Pattern:** Acts as an abstraction layer between the data sources (API/local storage) and the business logic, resulting in cleaner, reusable, and loosely coupled code.

This architecture improves code organization, scalability, maintainability, and testability.

## Dependencies

All required dependencies are listed in `pubspec.yaml`.

Install them using:

```bash
flutter pub get
```