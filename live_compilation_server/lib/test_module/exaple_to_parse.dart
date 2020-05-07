import 'mock_framework.dart';

class TestWidget extends StatelessWidget {

  TestWidget({this.width});

  final DoubleObject width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
    );
  }
}
