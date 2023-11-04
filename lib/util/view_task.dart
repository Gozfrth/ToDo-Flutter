import 'package:flutter/material.dart';

class ViewTask extends StatelessWidget {
  final String taskName;
  final bool taskCompleted;
  final DateTime taskTime;
  final String description;
  final String priority;
  final Color priorityColor;

  const ViewTask({
    super.key,
    required this.taskName,
    required this.taskCompleted,
    required this.taskTime,
    required this.description,
    required this.priority,
    required this.priorityColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xff272727),
          width: 1,
        ),
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(20),
        ),
        color: const Color(0xff272727),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
            left: 40.0, bottom: 40.0, right: 40.0, top: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Text>[
                Text(
                  taskName,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Color(0xffd9d9d9)),
                ),
                Text(
                  "[$priority]",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: priorityColor),
                ),
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            Container(
              height: 2,
              color: priorityColor,
            ),
            const SizedBox(
              height: 12,
            ),
            Text(
              textAlign: TextAlign.center,
              description,
              style: const TextStyle(fontSize: 15, color: Color(0xffd9d9d9)),
            )
          ],
        ),
      ),
    );
  }
}
