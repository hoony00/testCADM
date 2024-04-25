import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class CustomDropdownField extends StatelessWidget {
  final String hintText;
  final List<String> options;
  final String? selectedOption;
  final ValueChanged<String?> onChanged;

  const CustomDropdownField({
    Key? key,
    required this.hintText,
    required this.options,
    required this.onChanged,
    this.selectedOption,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.screenWidth * 0.90,
      height: context.screenWidth * 0.13,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey[300]!,
        ),
        borderRadius: BorderRadius.circular(10),
        color: Colors.white70,
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 16),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            isExpanded: true,
            value: selectedOption,
            hint: Text(
              hintText,
              style: TextStyle(color: Colors.grey),
            ),
            items: options.map((String option) {
              return DropdownMenuItem<String>(
                value: option,
                child: Text(option),
              );
            }).toList(),
            onChanged: onChanged,
          ),
        ),
      ),
    ).p16();
  }
}
