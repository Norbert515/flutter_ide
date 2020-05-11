
import 'package:flutter/material.dart';

class OutlineDropDownButton<T> extends StatelessWidget {

  final List<DropdownMenuItem<T>> items;
  final T value;
  final ValueChanged<T> onChanged;

  const OutlineDropDownButton({Key key, this.value, this.onChanged, this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: ShapeDecoration(
          shape: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.white
              )
          )
      ),
      child: DropdownButton<T>(
        isExpanded: true,
        isDense: true,
        underline: SizedBox(),
        value: value,
        items: items,
        onChanged: onChanged,
      ),
    );
  }
}

