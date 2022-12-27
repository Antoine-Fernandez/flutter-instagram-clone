# Instagram clone

This project it's a school project. It's an limited clone of one of the famous social network Instagram

![Logo](https://www.meilleure-innovation.com/wp-content/uploads/2022/04/logo-instagram-788x444.png)

## Features

- [x]  Login / Signup
- [x]  add a post with description
- [x]  Feed of post
- [x]  Comment a post
- [x]  like a post (animated like)
- [x]  Search users
- [x]  Follow / unfollow users
- [x]  profil
- [x]  Delete my own post
- [x]  Delete post (only for admin)

## Dependencies

-   [cloud_firestore](https://pub.dev/packages/cloud_firestore) to handle firestore interaction
-   [cupertino_icons](https://pub.dev/packages/cupertino_icons) for navigation icon
-   [firebase_auth](https://pub.dev/packages/firebase_auth) to handle user authentification
-   [firebase_core](https://pub.dev/packages/firebase_core) to use firebase app features
-   [firebase_storage](https://pub.dev/packages/firebase_storage) to store pictures
-   [flutter_staggered_grid_view](https://pub.dev/packages/flutter_staggered_grid_view) to display pictures in user search
-   [flutter_svg](https://pub.dev/packages/flutter_svg) to render svg
-   [image_picker](https://pub.dev/packages/image_picker) to pick image from the current device
-   [intl](https://pub.dev/packages/intl) to display date on a good format
-   [provider](https://pub.dev/packages/provider) global state management
-   [uuid](https://pub.dev/packages/uuid) to generate unique ID

## Deploy locally

**Step 1 :**

Download or clone this repo by using the link below:

```
https://github.com/Antoine-Fernandez/instagram.git
```

**Step 2 :**

Go to project root and execute the following command in console to get the required dependencies:

```
flutter pub get
```

**Step 3 :**

Launch your simulator ([official documentation](https://docs.flutter.dev/get-started/install))

**Step 4 - mobile :**

```
flutter run
```

**Step 4 - web :**

```
flutter run -d chrome --web-renderer html
```

## Architecture

Here is the core folder structure of the project.

```
flutter-app/
|- android
|- assets
|- build
|- ios
|- lib
|- linux
|- macos
|- test
|- web
|- windows
```

Here is the lib structure that I created.

```
flutter-app/
|- models
|- providers
|- resources
|- responsive
|- screns
|- utils
|- widget
|- firebase_options.dart
|- main.dart
```

**Models :**
Folder which contains my data models. You can find the user and post model.

**Providers :**
Folder which contains my global state management class.

**Resources :**
Folder which contains my api call to interact with firebase.

**Responsive :**
Folder that contains my layout.

**Screens :**
Folder that contains all the screens of the app.

**Utils :**
Folder that contains useful functions and configuration. You can find my color configuration, my list of screen to navigate, and some utils like showSnackBar.

**Widget :**
Folder that contains all the widgets of the app like post card, comment card.

**Screens :**
Folder that contains all the screens of the app.

You can alsow find the main file and the firebase options.
