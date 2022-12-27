# Instagram clone

This project it's a school project. It's an limited clone of one of the famous social network Instagram

![Logo](https://www.meilleure-innovation.com/wp-content/uploads/2022/04/logo-instagram-788x444.png)

## Features

-   Login / Signup
-   add a post with description
-   Feed of post
-   Comment a post
-   like a post (animated like)
-   Search users
-   Follow / unfollow users
-   profil
-   Delete my own post
-   Delete post (only for admin)

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
