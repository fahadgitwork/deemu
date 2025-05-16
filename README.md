# Deemu

A new Flutter project with modern architecture and essential dependencies for building robust mobile applications.

## Getting Started

This project is built with Flutter. To get started, make sure you have the following prerequisites:

### Prerequisites

- Flutter SDK (^3.7.2)
- Dart SDK
- Android Studio / VS Code with Flutter extensions
- iOS development setup (for iOS development)

### Installation

1. Clone the repository:
```bash
git clone [repository-url]
cd deemu
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the app:
```bash
flutter run
```

## Project Structure

```
deemu/
├── lib/           # Source code
├── assets/        # Project assets (images, icons)
├── test/          # Test files
├── android/       # Android-specific files
├── ios/          # iOS-specific files
├── web/          # Web-specific files
└── pubspec.yaml   # Project configuration
```

## Dependencies

The project uses several key dependencies:

- **flutter_svg**: ^2.0.9 - For SVG image support
- **dio**: ^5.4.0 - For HTTP networking
- **json_annotation**: ^4.8.1 - For JSON serialization
- **provider**: ^6.1.1 - For state management
- **build_runner**: ^2.4.8 - For code generation
- **json_serializable**: ^6.7.1 - For JSON serialization code generation

## Development

To generate code for JSON serialization:
```bash
flutter pub run build_runner build
```

## Platforms

This project supports multiple platforms:
- Android
- iOS
- Web
- Linux
- macOS
- Windows

## Contributing

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License

This project is proprietary and confidential.

## Contact

Your Name - [Muhammad Fahad](mailto:mf6309559@gmail.com)

Project Link: [https://github.com/fahadgitwork/deemu](https://github.com/fahadgitwork/deemu)
