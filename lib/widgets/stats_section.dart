import 'package:flutter/material.dart';

class StatsSection extends StatelessWidget {
  final int totalTasks;
  final int completedTasks;
  final int pendingTasks;

  const StatsSection({
    super.key,
    required this.totalTasks,
    required this.completedTasks,
    required this.pendingTasks,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        buildStatCard(
          'All Tasks',
          totalTasks.toString(),
          Icons.list,
          Colors.indigo,
        ),
        buildStatCard(
          'Completed',
          completedTasks.toString(),
          Icons.check_circle_outline,
          Colors.green,
        ),
        buildStatCard(
          'Pending',
          pendingTasks.toString(),
          Icons.access_time,
          Color.fromARGB(255, 226, 136, 0),
        ),
      ],
    );
  }

  Widget buildStatCard(
    String title,
    String count,
    IconData icon,
    Color sectionColor,
  ) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5),
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withAlpha(35),
              spreadRadius: 2,
              blurRadius: 6,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, color: sectionColor, size: 30),
            SizedBox(height: 8),
            Text(title, style: TextStyle(fontSize: 15, color: Colors.black)),
            SizedBox(height: 6),
            Text(
              count,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: sectionColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}