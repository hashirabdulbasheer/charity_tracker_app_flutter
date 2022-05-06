# charity_tracker_app_flutter

Each ramadan, we calculate our zakat and how much we have to spend in charity. For that, we have to remember
and keep track of our charity spending for the last year. This app keeps track of our charity by saving the data
into a personal centralized firebase cloud database. This helps multiple users to work together
towards a charity goal. Each member of a family can add his charity spending and track how much they have spent.

A flutter mobile app to collaborate for charity. Work together towards a charity goal.

![Charity Tracker App](https://raw.githubusercontent.com/hashirabdulbasheer/my_assets/master/charity_tracker_app.png)

# Dev Environment
- Android Studio Arctic Fox | 2020.3.1 Patch 3
- Flutter version : Flutter 2.13.0-0.0.pre.548 • channel master
- Tools • Dart 2.18.0 (build 2.18.0-19.0.dev) • DevTools 2.12.2

# Design
- Flutter Clean Architecture
- Flutter Bloc for state management
- Firebase for backend

# Backend preparation
- Create a realtime database in firebase console
- Register android and iOS apps and generate the google service json and plist files for them
- Place the google service files into the flutter app project in their designated folders.

# v1.0.0 features
- Add a charity
- Update a charity
- Delete an entry by swiping
- View list of charity entries

# Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

# Generate Translations
flutter pub run easy_localization:generate --source-dir ./assets/translations --output-dir ./lib/core/misc

