# Fix Flutter White Screen - .env Asset Issue

## Steps:
1. [x] Understand issue: dotenv.load() fails on web (missing assets declaration in pubspec.yaml)
2. [x] Edit pubspec.yaml: Add `assets: - .env`
3. [x] Run `flutter clean && flutter pub get`
4. [ ] Test `flutter run` - app should load (shows loading/error UI)
5. [ ] [Optional] Fix backend if HTTP error

**Current Status:** Editing pubspec.yaml next.

