import 'package:flutter/material.dart';
import 'package:widget_maker_2_0/data/properties/basic_properties.dart';

import 'changers.dart';

typedef ObjectConstructor<T> = T Function();


class AddOrRemoveButton<T> extends StatelessWidget {

  final ValueChanged<T> onChange;
  final ObjectConstructor emptyConstructor;
  final T value;

  const AddOrRemoveButton({Key key, this.onChange, this.emptyConstructor, this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RoundContainer(
        child: InkWell(
            onTap: () {
              if(value == null) {
                onChange(emptyConstructor());
              } else {
                onChange(null);
              }
            },
            child: Icon(value == null? Icons.add: Icons.remove)),
    );
  }
}

class AddableProperty<T> extends StatelessWidget {

  final String propertyName;
  final T value;
  final Widget child;
  final ObjectConstructor emptyConstructor;
  /// Called when the user adds or removes the property, the bool indicates
  /// whether a value is present after the interaction
  final ValueChanged<T> onChange;
  final bool sameLine;
  final bool isRequired;

  const AddableProperty({
    Key key,
    this.propertyName,
    this.value,
    this.child,
    this.onChange,
    this.emptyConstructor,
    this.sameLine = true,
    this.isRequired = false,
  })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var title = Text(
      MProperty.capitalize(propertyName),
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    );

    if(isRequired){
      return Row(
        children: <Widget>[
          title,
          Expanded(
            child: child,
          ),
        ],
      );
    }
    if (value == null) {
      return Row(
        children: <Widget>[
          title,
          Spacer(),
          Material(
            child: RoundContainer(
              child: InkWell(
                  onTap: () {
                    onChange(emptyConstructor());
                  },
                  child: Icon(Icons.add)),
            ),
          ),
        ],
      );
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            title,
            sameLine? Expanded(
              child: child,
            ) : Spacer(),
            RoundContainer(
              child: InkWell(
                  onTap: () {
                    onChange(null);
                  },
                  child: Icon(Icons.remove)),
            ),
          ],
        ),
        if(!sameLine)
          SizedBox(
           height: 16,
          ),
        if(!sameLine)
          child
      ],
    );


  }
}
