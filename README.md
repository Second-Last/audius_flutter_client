# audius_flutter_client

A new Flutter project.

## To-Do

* [ ] Improve app's navigation bar animation
* [ ] Add option to upload directly from mobile
* [ ] Add ability to show user address

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Formatting

### Imports

Our order for importing libraries and files is:

- Test target file(s), if we're testing
- (Native, factory) Dart library (e.g. `dart:async`, `dart:convert`)
- (Native, factory) Flutter library (e.g. `flutter/material.dart`, `flutter/foundation.dart`)
- Empty line
- Other Dart libraries (e.g. `https`, even though it's a first-party library)
- Other Flutter libraries (e.g. `just_audio`)
- Empty line
- Libraries/Reusable components that are local to this project (e.g. `audius_flutter_client/models/track.dart`)