import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo/util/view_task.dart';

// ignore: must_be_immutable
class ToDoTile extends StatefulWidget {
  final String taskName;
  final bool taskCompleted;
  final DateTime taskTime;
  final String description;
  final String priority;
  Function(bool?)? onChanged;
  Function(BuildContext) deleteFunction;
  final Color priorityColor;
  final dateCompleted;

  ToDoTile({
    super.key,
    required this.taskName,
    required this.taskCompleted,
    required this.taskTime,
    required this.onChanged,
    required this.deleteFunction,
    required this.description,
    required this.priority,
    required this.dateCompleted,
  }) : priorityColor = (priority == 'high')
            ? const Color(0xffdd7777)
            : (priority == 'medium')
                ? const Color(0xff7777dd)
                : const Color(0xff77dd77);

  @override
  State<ToDoTile> createState() => _ToDoTileState();
}

class _ToDoTileState extends State<ToDoTile> {
  void viewTask() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (context) {
        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: ViewTask(
                taskName: widget.taskName,
                description: widget.description,
                taskCompleted: widget.taskCompleted,
                taskTime: widget.taskTime,
                priority: widget.priority,
                priorityColor: widget.priorityColor),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 5.0),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              onPressed: widget.deleteFunction,
              icon: Icons.delete,
              backgroundColor: const Color(0xffdd7777),
              borderRadius: BorderRadius.circular(12),
            )
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: const Color(0xff272727),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: widget.taskCompleted
                  ? const Color(0xffd1d1d1)
                  : widget.priorityColor,
              width: 2,
            ),
          ),
          child: Row(
            children: [
              Checkbox(
                fillColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                    return const Color(0xffd1d1d1);
                  },
                ),
                checkColor: const Color(0xff272727),
                value: widget.taskCompleted,
                onChanged: widget.onChanged,
                activeColor: Colors.black,
              ),
              Expanded(
                child: InkWell(
                  onTap: viewTask,
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start, // Align text to start
                    children: [
                      Text(
                        widget.taskName,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: const Color(0xffd9d9d9),
                          decoration: widget.taskCompleted
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                          decorationThickness: 3,
                        ),
                      ),
                      if (widget.description.isNotEmpty)
                        const SizedBox(
                          height: 4,
                        ),
                      if (widget.description.isNotEmpty)
                        Container(
                          margin: const EdgeInsets.only(right: 10),
                          color: widget.taskCompleted
                              ? const Color(0xffd9d9d9)
                              : widget.priorityColor,
                          height: 2,
                        ),
                      if (widget.description.isNotEmpty)
                        Text(
                          widget.description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: const Color(0xffd1d1d1),
                            fontSize: 10,
                            fontWeight: FontWeight.normal,
                            decoration: widget.taskCompleted
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                            decorationThickness: 3,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              Transform.translate(
                offset: const Offset(0, 15),
                child: Text(
                  '${widget.taskTime.day}/${widget.taskTime.month}/${widget.taskTime.year}',
                  style: const TextStyle(
                    color: Color(0xffd9d9d9),
                    letterSpacing: -1.0,
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
