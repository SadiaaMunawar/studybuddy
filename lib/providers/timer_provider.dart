import 'dart:async';
import 'package:flutter/foundation.dart';

class TimerProvider extends ChangeNotifier {
  int sessionMinutes = 25;
  int breakMinutes = 5;
  int remainingSeconds = 0;
  bool running = false;
  bool onBreak = false;
  Timer? _timer;

  void startSession() {
    onBreak = false;
    remainingSeconds = sessionMinutes * 60;
    _start();
  }

  void startBreak() {
    onBreak = true;
    remainingSeconds = breakMinutes * 60;
    _start();
  }

  void _start() {
    running = true;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (remainingSeconds <= 0) {
        t.cancel();
        running = false;
        notifyListeners();
      } else {
        remainingSeconds--;
        notifyListeners();
      }
    });
  }

  void stop() {
    _timer?.cancel();
    running = false;
    notifyListeners();
  }

  void setDurations({required int session, required int brk}) {
    sessionMinutes = session;
    breakMinutes = brk;
    notifyListeners();
  }
}
