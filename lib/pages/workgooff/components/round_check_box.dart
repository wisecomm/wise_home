import 'package:flutter/material.dart';

class RoundCheckBox extends StatelessWidget {
  const RoundCheckBox({
    Key? key,
    required this.label,
    required this.value,
    required this.onChanged,
    this.padding,
  }) : super(key: key);

  final String label;
  final bool value;
  final Function onChanged;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }

      if (value) return Colors.red;
      return Colors.black;
    }

    return InkWell(
      onTap: () {
        onChanged(!value);
      },
      child: Row(
        children: <Widget>[
          Checkbox(
            checkColor: Colors.white,
            fillColor: MaterialStateProperty.resolveWith(getColor),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ),
            value: value,
            onChanged: (bool? newValue) {
              onChanged(newValue);
            },
          ),
          Padding(
            padding: padding ?? const EdgeInsets.symmetric(horizontal: 0.0),
            child: Text(
              label,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
