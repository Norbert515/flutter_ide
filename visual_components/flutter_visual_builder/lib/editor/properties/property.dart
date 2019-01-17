import 'package:meta/meta.dart';

/// This contains the properties as source code which would be lost otherwise when accessed at runtime.
///
/// For example:
///
/// return Container(
///   color: myColor,
/// );
///
/// Would evaluate to "myColor" during runtime, but we'd like to keep the variable, therefore
/// it is saved as:
///
/// Property("color", "myColor")
abstract class Property {

  Property({@required this.name});

  final String name;
  String get sourceCode;
}


/// A property which can not be changed from the outside
///
/// It only contains the source code used to reconstruct the original
class UnknownProperty extends Property {

  UnknownProperty({@required String name, @required this.sourceCode}): super(name: name);


  final String sourceCode;
}



class AlignmentProperty extends Property {

 AlignmentProperty({@required String name}): super(name: name);

  @override
  // TODO: implement sourceCode
  String get sourceCode => null;

}