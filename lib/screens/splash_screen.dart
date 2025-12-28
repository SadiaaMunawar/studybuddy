import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';

import '../providers/auth_provider.dart';
import '../providers/task_provider.dart';
import '../app_router.dart';
import '../theme/app_theme.dart'; // for colors/fonts

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();

    // Animation setup
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _scale = CurvedAnimation(parent: _controller, curve: Curves.easeOutBack);
    _controller.forward();

    // Delay navigation so splash is visible
    Timer(const Duration(seconds: 3), _navigate);
  }

  void _navigate() {
    final auth = context.read<AuthProvider>();

    if (auth.isLoggedIn) {
      context.read<TaskProvider>().watch();
      Navigator.pushReplacementNamed(context, AppRouter.home);
    } else {
      Navigator.pushReplacementNamed(context, AppRouter.signup);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.indigo, Colors.deepPurple],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: ScaleTransition(
            scale: _scale,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Logo image (tinted white if needed)
                Image.asset(
                  'assets/images/graduation-hat.png',
                  height: 100,
                  width: 100,
                  color: Colors.white, // ✅ makes logo appear white
                ),
                const SizedBox(height: 16),
                Text(
                  'Study Buddy',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Focus. Learn. Achieve.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 32),
                const CircularProgressIndicator(color: Colors.white),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
