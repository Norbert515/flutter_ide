import 'package:flutter_test/flutter_test.dart';
import 'package:widget_maker_2_0/data/bs/widget_board/widget_board.dart';

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