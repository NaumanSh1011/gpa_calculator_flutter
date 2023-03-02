import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gpa_calculator/Classes/criteria_unit.dart';

// ignore: must_be_immutable
class CriteriaWidget extends StatefulWidget {
  CriteriaWidget({
    Key? key,
    required this.criteria,
    required this.limitController,
    required this.gradeController,
    required this.index,
  }) : super(key: key);

  List<CriteriaUnit> criteria;
  List<TextEditingController> limitController;
  List<TextEditingController> gradeController;
  int index;
  @override
  State<CriteriaWidget> createState() => _CriteriaWidgetState();
}

class _CriteriaWidgetState extends State<CriteriaWidget> {
  @override
  Widget build(BuildContext context) {
    widget.limitController[widget.index].text = widget.criteria[widget.index].lowerLimit.toString();
    widget.gradeController[widget.index].text = widget.criteria[widget.index].gradePoints.toString();
    return Row(
      children: [
        Opacity(
          opacity: widget.index == 0 ? 0 : 1,
          child: Checkbox(
            value: false,
            onChanged: (bool? value) {
              setState(() {
                widget.criteria[widget.index].isDistributed = value!;
              });
            },
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: TextField(
            controller: widget.limitController[widget.index],
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              hintText: 'Lower Limit',
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: TextField(
            controller: widget.gradeController[widget.index],
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
            ],
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              hintText: 'Grade Points',
            ),
          ),
        ),
      ],
    );
  }
}