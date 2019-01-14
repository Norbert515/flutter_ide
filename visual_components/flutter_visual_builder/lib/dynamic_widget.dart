import 'package:flutter/material.dart';
import 'package:flutter_visual_builder/components/visual_components.dart';
import 'package:uuid/uuid.dart';

var uuid = new Uuid();


VisualStatefulWidget get testWidget => VisualWrapper(
  id: uuid.v1(),
  child: Container(
    color: Colors.green,
    width: 50,
    height: 100,
  ),
  sourceCode: 'Container(color: Colors.green, width: 50, height: 100,),',
);

VisualStatefulWidget get testWidget2 => VisualFloatingActionButton(
  id: uuid.v1(),
  backgroundColor: Colors.red,
  onPressed: (){},
);

VisualStatefulWidget get testWidget3 => VisualWrapper(
    id: uuid.v1(),
    child: Icon(Icons.add),
    sourceCode: 'Icon(Icons.add)',
);



VisualStatefulWidget get testWidget4 => VisualContainer(
  color: Colors.green,
  id: uuid.v1(),
  height: 100,
  width: 100,
);

VisualStatefulWidget get testWidget5 => VisualColumn(
  id: uuid.v1(),
);