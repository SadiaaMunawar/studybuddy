Study Buddy
‘Study Buddy’ is a productivity and learning companion app built with Flutter.  
It helps students and professionals manage tasks, track study sessions, and stay organized with reminders and notifications.  
The app integrates Firebase Authentication for secure login and Cloud Firestore for real-time task storage, with optional offline caching.
 Features
•	User authentication using Firebase Auth (signup, login, logout)
•	Task management (add, update, delete, reschedule tasks)
•	Pomodoro timer for focused study sessions
•	Statistics dashboard:
•	Completed tasks
•	Pending tasks
•	Overdue tasks
•	Completion percentage
•	Deadline notifications using local notification service
•	Light and dark theme toggle using Provider
•	Offline caching using Hive (optional)

Tech Stack
•	Flutter (UI framework)
•	Firebase Core (project initialization)
•	Firebase Authentication (user authentication)
•	Cloud Firestore (task storage and synchronization)
•	Hive (local caching)
•	Provider (state management)
•	Local notifications (deadline reminders)

How to Run the App?

1. Clone the Repository
git clone https://github.com/your-username/study-buddy.git
cd study-buddy

2. Install Dependencies
flutter pub get
3. Configure Firebase
•	Create a Firebase project at:
  [https://console.firebase.google.com](https://console.firebase.google.com)
•	Add your Android and/or iOS app
•	Download the configuration files:

`google-services.json` and place it in `android/app/`
`GoogleService-Info.plist` and place it in `ios/Runner/`
Run the FlutterFire CLI to generate Firebase configuration:

flutterfire configure

4. Run the App
flutter run
5. Build APK (Release)
flutter build apk --release
•	APK will be generated at:
build/app/outputs/flutter-apk/app-release.apk

Challenges Faced

•	Repeated build issues across VS Code and Android Studio despite correct setup.
•	GitHub Actions configuration using YAML failed, indicating issues were not IDE-specific.
•	Migration from Hive to Firestore required restructuring of providers and authentication logic.

Future Improvements

•	Add collaborative study groups with shared tasks
•	Implement cloud backup for Pomodoro timer statistics
•	Enhance UI with animations and progress charts


