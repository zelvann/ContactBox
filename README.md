*This is a submission for the Mobile Programming Assignment to explore the mobile database.*

## What I Built
I created a user-friendly mobile app that lets users manage their contacts with ease. The app allows you to view a list of contacts, add new ones, and delete any you no longer need.

To handle data storage, I used <strong>ObjectBox</strong>, a fast and lightweight local database built for mobile. It keeps everything running smoothly, even offline and makes saving and loading data almost instant.

Key highlights of the project include:
- A real-time, scrollable contact list with automatic updates
- Intuitive add and delete functionality with instant feedback
- Lightweight local storage powered by <strong>ObjectBox</strong> for rapid performance and persistent data

### Installation & Setup
```bash
git clone https://github.com/zelvann/ContactBox.git
cd ContactBox
```
Then install dependencies,
```bash
flutter pub get
```
After that, run the app
```bash
flutter run
```

### Development workflow
- I started by defining the contact entity schema using <strong>ObjectBox</strong> annotations, which laid the groundwork for the app's data layer. You can see this [folder](https://github.com/zelvann/ContactBox/tree/main/lib/entity) to figure it out.
- To achieve it, we should get the support dependencies on it such as <strong>ObjectBox</strong> , <strong>build_runner</strong>, and <strong>path_provider</strong> as helper.
  ```bash
  flutter pub add objectbox objectbox_flutter_libs path_provider
  flutter pub add --dev build_runner objectbox_generator
  ```
- Then, generate the binding code required to use <strong>ObjectBox</strong> by using <code>build_runner</code> package which we've added in the previous step.
  ```bash
  dart run build_runner build
  ```
- <strong>ObjectBox</strong> can be used right now. Support it, with the Application UI which for our case is Contact Management.

#### Reference
[https://docs.objectbox.io](https://docs.objectbox.io/)