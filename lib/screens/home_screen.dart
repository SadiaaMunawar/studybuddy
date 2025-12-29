import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/task_provider.dart';
import '../providers/auth_provider.dart';
import '../widgets/task_card.dart';
import '../widgets/progress_chart.dart';
import '../app_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final taskProvider = context.watch<TaskProvider>();
    final auth = context.watch<AuthProvider>();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.school, color: Colors.white, size: 20),
            ),
            const SizedBox(width: 12),
            const Text(
              'StudyBuddy',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 22,
                color: Color(0xFF1E293B),
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () => Navigator.pushNamed(context, AppRouter.notifications),
            icon: const Icon(Icons.notifications_outlined, color: Color(0xFF64748B)),
          ),
          IconButton(
            tooltip: 'Logout',
            onPressed: () => auth.signOut(),
            icon: const Icon(Icons.logout, color: Colors.indigo),
          ),
        ],
      ),
      drawer: const StudyBuddyDrawer(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF6366F1),
        onPressed: () async {
          await Navigator.pushNamed(context, AppRouter.taskEditor);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Task added successfully!')),
          );
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: taskProvider.loading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: () async {
                await taskProvider.refresh();
              },
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                children: [
                  const SizedBox(height: 8),
                  const Text(
                    'Hello, Student! 👋',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1E293B),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Ready to focus and achieve today?',
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 20),

                  // Stat Cards
                  Row(
                    children: [
                      _StatCard(
                        value: '${taskProvider.completedTasks}',
                        label: 'Completed',
                        color: const Color(0xFF10B981),
                        icon: Icons.check_circle,
                      ),
                      const SizedBox(width: 12),
                      _StatCard(
                        value: '${taskProvider.pendingTasks}',
                        label: 'Pending',
                        color: const Color(0xFFF59E0B),
                        icon: Icons.pending,
                      ),
                      const SizedBox(width: 12),
                      _StatCard(
                        value: '${taskProvider.todayTasks}',
                        label: 'Today',
                        color: const Color(0xFF6366F1),
                        icon: Icons.today,
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  const Text(
                    'Quick Access',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1E293B),
                    ),
                  ),
                  const SizedBox(height: 12),
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 4,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.9,
                    children: [
                      _QuickCard('Dictionary', Icons.book, Colors.blue, () {
                        Navigator.pushNamed(context, AppRouter.dictionary);
                      }),
                      _QuickCard('FocusTimer', Icons.timer, Colors.orange, () {
                        Navigator.pushNamed(context, AppRouter.focusTimer);
                      }),
                      _QuickCard('Flashcards', Icons.lightbulb, Colors.purple, () {
                        Navigator.pushNamed(context, AppRouter.flashcards);
                      }),
                      _QuickCard('Resources', Icons.library_books, Colors.teal, () {
                        Navigator.pushNamed(context, AppRouter.resources);
                      }),
                      _QuickCard('Study Plans', Icons.schedule, Colors.green, () {
                        Navigator.pushNamed(context, AppRouter.studyPlans);
                      }),
                      _QuickCard('Calendar', Icons.calendar_today, Colors.cyan, () {
                        Navigator.pushNamed(context, AppRouter.calendar);
                      }),
                      _QuickCard('Analytics', Icons.analytics, Colors.red, () {
                        Navigator.pushNamed(context, AppRouter.analytics);
                      }),
                      _QuickCard('Groups', Icons.group, Colors.pink, () {
                        Navigator.pushNamed(context, AppRouter.studyGroups);
                      }),
                      // ✅ NEW OCR Quick Access
                      _QuickCard('OCR Scanner', Icons.document_scanner, Colors.deepPurple, () {
                        Navigator.pushNamed(context, AppRouter.ocr);
                      }),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Progress Chart
                  Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Study Progress',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF1E293B),
                            ),
                          ),
                          const SizedBox(height: 12),
                          ProgressChart(tasks: taskProvider.tasks),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Upcoming Tasks
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Upcoming Tasks',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF1E293B),
                        ),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pushNamed(context, AppRouter.taskManager),
                        child: const Text('View All', style: TextStyle(color: Color(0xFF6366F1))),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  if (taskProvider.tasks.isEmpty)
                    Column(
                      children: [
                        Icon(Icons.task, size: 64, color: Colors.grey[400]),
                        const SizedBox(height: 12),
                        Text('No tasks yet', style: TextStyle(fontSize: 16, color: Colors.grey[600])),
                        const SizedBox(height: 8),
                        Text('Tap + to add your first task!', style: TextStyle(fontSize: 14, color: Colors.grey[500])),
                      ],
                    )
                  else
                    Column(
                      children: taskProvider.tasks
                          .take(3)
                          .map((t) => Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: TaskCard(task: t),
                              ))
                          .toList(),
                    ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String value;
  final String label;
  final Color color;
  final IconData icon;

  const _StatCard({
    required this.value,
    required this.label,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(color: Colors.grey.withOpacity(0.08), blurRadius: 6, spreadRadius: 1),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(height: 8),
            Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xFF1E293B))),
            const SizedBox(height: 2),
            Text(label, style: TextStyle(fontSize: 11, color: Colors.grey[600])),
          ],
        ),
      ),
    );
  }
}



class _QuickCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _QuickCard(this.title, this.icon, this.color, this.onTap);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 20, color: color),
              const SizedBox(height: 6),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Drawer
class StudyBuddyDrawer extends StatelessWidget {
  const StudyBuddyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: const Icon(Icons.school, color: Colors.white, size: 30),
                ),
                const SizedBox(height: 12),
                const Text(
                  'StudyBuddy',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Student Edition',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
              ],
            ),
          ),
          _DrawerTile(
            icon: Icons.dashboard,
            title: 'Dashboard',
            onTap: () => Navigator.pop(context),
          ),
          _DrawerTile(
            icon: Icons.task,
            title: 'Task Manager',
            onTap: () => Navigator.pushNamed(context, AppRouter.taskManager),
          ),
          _DrawerTile(
            icon: Icons.schedule,
            title: 'Study Plans',
            onTap: () => Navigator.pushNamed(context, AppRouter.studyPlans),
          ),
          _DrawerTile(
            icon: Icons.lightbulb,
            title: 'Flashcards',
            onTap: () => Navigator.pushNamed(context, AppRouter.flashcards),
          ),
          _DrawerTile(
            icon: Icons.library_books,
            title: 'Resources',
            onTap: () => Navigator.pushNamed(context, AppRouter.resources),
          ),
          _DrawerTile(
            icon: Icons.group,
            title: 'Study Groups',
            onTap: () => Navigator.pushNamed(context, AppRouter.studyGroups),
          ),
          _DrawerTile(
            icon: Icons.timer,
            title: 'Focus Timer',
            onTap: () => Navigator.pushNamed(context, AppRouter.focusTimer),
          ),
          _DrawerTile(
            icon: Icons.analytics,
            title: 'Analytics',
            onTap: () => Navigator.pushNamed(context, AppRouter.analytics),
          ),
          _DrawerTile(
            icon: Icons.calendar_today,
            title: 'Calendar',
            onTap: () => Navigator.pushNamed(context, AppRouter.calendar),
          ),
          // ✅ NEW OCR Drawer Item
          _DrawerTile(
            icon: Icons.document_scanner,
            title: 'OCR Scanner',
            onTap: () => Navigator.pushNamed(context, AppRouter.ocr),
          ),
          const Divider(),
          _DrawerTile(
            icon: Icons.settings,
            title: 'Settings',
            onTap: () => Navigator.pushNamed(context, AppRouter.settings),
          ),
          _DrawerTile(
            icon: Icons.help,
            title: 'Help',
            onTap: () => Navigator.pushNamed(context, AppRouter.help),
          ),
          _DrawerTile(
            icon: Icons.info,
            title: 'About',
            onTap: () => Navigator.pushNamed(context, AppRouter.about),
          ),
        ],
      ),
    );
  }
}

class _DrawerTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _DrawerTile({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF64748B)),
      title: Text(title),
      onTap: onTap,
    );
  }
}