# Slate

A Flutter recreation of a clean banking app UI concept: an animated splash, a login screen with a curved header, and a home screen with balance, card and recent transactions.

## Credits

The design and animations are **not mine**. This project is a study that rebuilds, from scratch, the UI shown in this video by **Daily FlutterUI**:

▶️ [Clean Flutter Banking App UI Concept — Daily FlutterUI](https://www.youtube.com/shorts/iYKn9ludET8)

All credit for the concept goes to the original author. The code here was written by watching the video; it is not the author's source code.

## What's inside

- **Splash** — the brand rises in, then slides out to the right.
- **Login** — the black splash drains into a curved header, the form rises in item by item, and the login button collapses into a pill with a gooey two-dot loader.
- **Home** — the header floods the screen, then the balance counts up, the card rises and the transactions and bottom bar come in.

Login is simulated: any valid-looking email and a non-empty password take you to the home screen. Account data is sample data.

## Running

```sh
flutter pub get
flutter run
```

It runs on iOS, Android and the web. For the web:

```sh
flutter run -d chrome   # development
flutter build web       # production build in build/web
```

On wide screens the app stays at phone width, centered.

## Project structure

```
lib/
  screens/   splash, login and home (state + composition only)
  widgets/   one component per file, grouped by feature (common, splash, login, home)
  models/    transaction
  data/      sample account data
  theme/     colors and theme
  utils/     formatters and helpers
```

## Third-party assets

- [Plus Jakarta Sans](https://github.com/tokotype/PlusJakartaSans) — SIL Open Font License (see `assets/fonts/OFL.txt`).
- [iconsax_flutter](https://pub.dev/packages/iconsax_flutter) — icons.
