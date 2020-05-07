import 'package:flutter/material.dart';

import 'common.dart';
import 'value_row.dart';

/// TODO make stateless
class MultiChanger<T> extends StatefulWidget {

  const MultiChanger({Key key, this.changer, this.options, this.onChange, this.name, this.selectedOption, this.names}) : super(key: key);

  final Widget changer;
  final List<T> options;
  final List<String> names;
  final T selectedOption;
  final ValueChanged<T> onChange;
  final String name;

  @override
  _MultiChangerState<T> createState() => _MultiChangerState<T>();
}

class _MultiChangerState<T> extends State<MultiChanger> {



  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
          children: <Widget>[
            PropertyText(text: widget.name),
            SizedBox(
              width: 16,
            ),
            Expanded(
              child: OutlineDropDownButton<T>(
                value: widget.selectedOption,
                items: widget.options.map((it) {
                  return DropdownMenuItem<T>(
                    value: it,
                    child: Text(widget.names[widget.options.indexOf(it)]),
                  );
                }).toList(),
                onChanged: (it) {
                  widget.onChange(it);
                },
              ),
            ),
          ],
        ),
        SizedBox(
          height: 16,
        ),
        widget.changer,
        //buildChangerForOption(context, id, selectedOption),
      ],
    );
  }
}
