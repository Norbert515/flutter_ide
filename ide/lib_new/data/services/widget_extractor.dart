

import 'dart:async';

import 'ide_source_code_modifier.dart';

class WidgetExtractor {

  WidgetExtractor._();

  factory WidgetExtractor () => _widgetExtractor;
  static WidgetExtractor _widgetExtractor = WidgetExtractor._();

  final IdeSourceCodeModifier _sourceCodeModifier = IdeSourceCodeModifier();

  final RegExp regExp = RegExp(r"class\s+\S+\s+extends\s+StatelessWidget\s+{");


  Future renderWidgetInIDE(String sourceCode) {
    WidgetCode widgetCode = _extractWidget(sourceCode);
    return _sourceCodeModifier.writeWidget(widgetCode.className, widgetCode.code);
  }
  
  bool isExecutable(String sourceCode) {
    List<Match> matches = regExp.allMatches(sourceCode).toList();
    if(matches.length != 1) return false;
    return true;
  }

  WidgetCode _extractWidget(String sourceCode) {
    List<Match> matches = regExp.allMatches(sourceCode).toList();
    assert(matches.length == 1);

    Match match = matches[0];
    int end = match.end;
    String stripped = sourceCode.substring(end);

    String className = match.group(0).split(RegExp(r"\s+")).elementAt(1);

    _BracketMatcher _bracketMatcher = _BracketMatcher(stripped);

    int widgetEnd = _bracketMatcher.getEnd();
    int realWidgetEnd = widgetEnd + end;

    String strippedWiget = sourceCode.substring(match.start, realWidgetEnd);
    print("Result: $strippedWiget");
    return WidgetCode(
      code: strippedWiget,
      className: className,
    );

  }

}

class _BracketMatcher {

  _BracketMatcher(this.codeSegment);

  final String codeSegment;

  final RegExp brackets = RegExp(r"{|}");
  int numberOfOpenBrackets = 1;


  int getEnd() {
    for(Match it in brackets.allMatches(codeSegment)) {
      assert(it.groupCount == 0);
      if(it.group(0) == "{") {
        numberOfOpenBrackets++;
      } else if(it.group(0) == "}") {
        numberOfOpenBrackets--;
      }
      if(numberOfOpenBrackets == 0) {
        return it.end;
      }
    }
    return -1;
  }



}

class WidgetCode {

  WidgetCode({this.startLine, this.endLine, this.code, this.className});

  final int startLine;
  final int endLine;
  final String code;
  final String className;

}