import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore: must_be_immutable
class CourseWidget extends StatefulWidget {
  CourseWidget({
    Key? key,
    required this.courseController,
    required this.creditController,
    required this.index,
  }) : super(key: key);

  List<TextEditingController> courseController;
  List<TextEditingController> creditController;
  int index;
  @override
  State<CourseWidget> createState() => _CourseWidgetState();
}

class _CourseWidgetState extends State<CourseWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Text('${widget.index + 1}'),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: widget.courseController[widget.index],
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
              ],
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                hintText: 'Course Mark',
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: widget.creditController[widget.index],
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                hintText: 'Credit Hours',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
