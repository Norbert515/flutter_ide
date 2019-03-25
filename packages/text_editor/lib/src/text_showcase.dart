import 'package:flutter/material.dart';
import 'package:text_editor/src/syntax_highlighter.dart';

class CodeShowcase extends StatelessWidget {

  CodeShowcase({Key key, this.sourceCode}) : super(key: key);

  final String sourceCode;

  final DartSyntaxHighlighter highlighter = DartSyntaxHighlighter(SyntaxHighlighterStyle.customThemeStyle());

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: highlighter.format(sourceCode),
    );
  }
}
