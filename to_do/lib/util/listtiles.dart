import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class Tiles extends StatelessWidget {
  final String task;
  final bool value;
  final Function(bool?)? onChanged;
  final Function(BuildContext)? deleteList;
  const Tiles({
    super.key,
    required this.task,
    required this.value,
    required this.onChanged,
    required this.deleteList,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Slidable(
        endActionPane: ActionPane(
          motion: StretchMotion(),
          children: [
            SlidableAction(
              onPressed: deleteList,
              icon: Icons.delete,
              borderRadius: BorderRadius.circular(5),
            ),
          ],
        ),
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.blueGrey,
            border: Border.all(),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Checkbox(value: value, onChanged: onChanged),
              Text(task),
            ],
          ),
        ),
      ),
    );
  }
}
