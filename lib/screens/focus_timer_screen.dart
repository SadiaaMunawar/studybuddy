import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/timer_provider.dart';

class FocusTimerScreen extends StatelessWidget {
  const FocusTimerScreen({super.key});

  String _format(int seconds) {
    final m = (seconds ~/ 60).toString().padLeft(2, '0');
    final s = (seconds % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  @override
  Widget build(BuildContext context) {
    final timer = context.watch<TimerProvider>();
    return Scaffold(
      appBar: AppBar(title: const Text('Focus Timer')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(timer.onBreak ? 'Break' : 'Focus', style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 12),
            Text(
              _format(timer.remainingSeconds),
              style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            Wrap(
              spacing: 12,
              children: [
                ElevatedButton(
                  onPressed: timer.running ? null : timer.startSession,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                    padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
                    minimumSize: const Size(150, 50), // ✅ Bigger size
                    textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  child: const Text('Start Focus'),
                ),
                ElevatedButton(
                  onPressed: timer.running ? null : timer.startBreak,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
                    minimumSize: const Size(150, 50), // ✅ Bigger size
                    textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  child: const Text('Start Break'),
                ),
                OutlinedButton(
                  onPressed: timer.running ? timer.stop : null,
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                    minimumSize: const Size(120, 45),
                    textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                  child: const Text('Stop'),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Focus (min):'),
                const SizedBox(width: 8),
                DropdownButton<int>(
                  value: timer.sessionMinutes,
                  items: [15, 20, 25, 30, 45, 60]
                      .map((e) => DropdownMenuItem(value: e, child: Text('$e')))
                      .toList(),
                  onChanged: (v) => timer.setDurations(session: v!, brk: timer.breakMinutes),
                ),
                const SizedBox(width: 16),
                const Text('Break (min):'),
                const SizedBox(width: 8),
                DropdownButton<int>(
                  value: timer.breakMinutes,
                  items: [5, 10, 15]
                      .map((e) => DropdownMenuItem(value: e, child: Text('$e')))
                      .toList(),
                  onChanged: (v) => timer.setDurations(session: timer.sessionMinutes, brk: v!),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
