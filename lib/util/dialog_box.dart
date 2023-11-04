import 'package:flutter/material.dart';
import 'package:todo/util/my_button.dart';

// ignore: must_be_immutable
class DialogBox extends StatefulWidget {
  final TextEditingController titleController;
  final TextEditingController descriptionController;
  String selectedPriority;
  void Function(String) selectedPrioritySetter;
  VoidCallback onSave;
  VoidCallback onCancel;

  DialogBox({
    super.key,
    required this.titleController,
    required this.descriptionController,
    required this.selectedPriority,
    required this.selectedPrioritySetter,
    required this.onSave,
    required this.onCancel,
  });

  @override
  State<DialogBox> createState() => _DialogBoxState();
}

class _DialogBoxState extends State<DialogBox> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20),
            ),
            color: Color(0xff272727),
          ),
          padding: const EdgeInsets.all(25), // Set the background color
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 15),
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Color(0xff272727), width: 1),
                      ),
                    ),
                    child: const Text(
                      "Add Task",
                      style: TextStyle(
                          color: Color(0xffd1d1d1),
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  //Dropdown
                  DropdownButton<String>(
                    padding: const EdgeInsets.only(right: 15),
                    borderRadius: BorderRadius.circular(12),
                    value: widget.selectedPriority,
                    underline: Container(
                      height: 1,
                      color: const Color(0xffd9d9d9),
                    ),
                    dropdownColor: const Color(0xff272727),
                    onChanged: (String? newValue) {
                      setState(() {
                        widget.selectedPriority = newValue!;
                      });
                      widget.selectedPrioritySetter(newValue!);
                    },
                    items: <String>['high', 'medium', 'low']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Color(0xffd9d9d9),
                          ),
                        ),
                      );
                    }).toList(),
                  )
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              // User input
              Column(
                children: [
                  TextField(
                    controller: widget.titleController,
                    style: const TextStyle(
                      color: Colors.white, // Set text color to white
                    ),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Enter a new task.",
                      hintStyle: TextStyle(
                        color: Color(0xffd1d1d1),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: widget.descriptionController,
                    style: const TextStyle(
                      color: Colors.white, // Set text color to white
                    ),
                    maxLines: null,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Enter a task description.",
                      hintStyle: TextStyle(
                        color: Color(0xffd1d1d1),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  MyButton(text: "Save", onPressed: widget.onSave),
                  const SizedBox(
                    width: 8,
                  ),
                  MyButton(text: "Cancel", onPressed: widget.onCancel)
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
