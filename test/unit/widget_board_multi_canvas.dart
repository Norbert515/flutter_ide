import 'package:flutter_test/flutter_test.dart';
import 'file:///C:/Users/Norbert/workspace/flutter_ide/lib/modules/workspace/widget_board.dart';

void main() {
  test('Widget board default canvas', () async {
    var board = WidgetBoard();
    var canvases = board.canvases;

    // We have one canvas at the very beginning
    expect(canvases.length, equals(1));
  });

  test('Widget board add canvas', () async {

  });
}