import 'package:flutter/material.dart';

class PowerStreamBuilder<T> extends StatelessWidget {

  final AsyncWidgetBuilder<T> builder;
  final T initialData;
  final Stream<T> stream;
  final bool customHandleError;

  const PowerStreamBuilder({Key key, this.builder, this.initialData, this.stream, this.customHandleError = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<T>(
      stream: stream,
      initialData: initialData,
      builder: (context, snapshot) {
        if(!customHandleError) {
          if(snapshot.hasError) {
            return ErrorWidget(snapshot.error);
          }
        }

        return builder(context, snapshot);

      },

    );
  }
}
