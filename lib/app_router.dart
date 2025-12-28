import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'screens/task_editor_screen.dart';
import 'screens/task_manager_screen.dart';
import 'screens/focus_timer_screen.dart';
import 'screens/dictionary_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/analytics_screen.dart';
import 'screens/flashcard_screen.dart';
import 'screens/resource_screen.dart';
import 'screens/study_plan_screen.dart';
import 'screens/calendar_screen.dart';
import 'screens/study_groups_screen.dart';
import 'screens/help_screen.dart';
import 'screens/about_screen.dart';
import 'screens/notifications_screen.dart';
// ✅ Import OCR screen
import 'screens/ocr_screen.dart';

class AppRouter {
  static const String splash = '/';
  static const String signup = '/signup';
  static const String login = '/login';
  static const String home = '/home';
  static const String taskEditor = '/taskEditor';
  static const String taskManager = '/taskManager';
  static const String focusTimer = '/focusTimer';
  static const String dictionary = '/dictionary';
  static const String settings = '/settings';
  static const String analytics = '/analytics';
  static const String flashcards = '/flashcards';
  static const String resources = '/resources';
  static const String studyPlans = '/studyPlans';
  static const String calendar = '/calendar';
  static const String studyGroups = '/studyGroups';
  static const String help = '/help';
  static const String about = '/about';
  static const String notifications = '/notifications';
  // ✅ New OCR route constant
  static const String ocr = '/ocr';

  static Route<dynamic> onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case signup:
        return MaterialPageRoute(builder: (_) => const SignUpScreen());
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case taskEditor:
        return MaterialPageRoute(builder: (_) => const TaskEditorScreen());
      case taskManager:
        return MaterialPageRoute(builder: (_) => const TaskManagerScreen());
      case focusTimer:
        return MaterialPageRoute(builder: (_) => const FocusTimerScreen());
      case dictionary:
        return MaterialPageRoute(builder: (_) => const DictionaryScreen());
      case settings:
        return MaterialPageRoute(builder: (_) => const SettingsScreen());
      case analytics:
        return MaterialPageRoute(builder: (_) => const AnalyticsScreen());
      case flashcards:
        return MaterialPageRoute(builder: (_) => const FlashcardScreen());
      case resources:
        return MaterialPageRoute(builder: (_) => const ResourceScreen());
      case studyPlans:
        return MaterialPageRoute(builder: (_) => const StudyPlanScreen());
      case calendar:
        return MaterialPageRoute(builder: (_) => const CalendarScreen());
      case studyGroups:
        return MaterialPageRoute(builder: (_) => const StudyGroupsScreen());
      case help:
        return MaterialPageRoute(builder: (_) => const HelpScreen());
      case about:
        return MaterialPageRoute(builder: (_) => const AboutScreen());
      case notifications:
        return MaterialPageRoute(builder: (_) => const NotificationsScreen());
      // ✅ OCR route handler
      case ocr:
        return MaterialPageRoute(builder: (_) => const OcrScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text(
                "Page not found",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey[600],
                ),
              ),
            ),
          ),
        );
    }
  }
}
