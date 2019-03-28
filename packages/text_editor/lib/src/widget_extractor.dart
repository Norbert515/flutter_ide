

class WidgetExtractor {



  WidgetExtractor(this.sourceCode): _bracketMatcher = _BracketMatcher(sourceCode);

  final String sourceCode;

  final _BracketMatcher _bracketMatcher;

  RegExp regExp = RegExp("class\s+\S+\s+extends\s+StatelessWidget\s+{");


  bool isExecutable() {
    List<Match> matches = regExp.allMatches(sourceCode).toList();
    if(matches.length != 1) return false;
    return true;

  }

  WidgetCode extractWidget() {
    
  }

}

class _BracketMatcher {

  _BracketMatcher(this.codeSegment);

  final String codeSegment;

  final RegExp brackets = RegExp("{|}");
  int numberOfOpenBrackets = 1;


  int getEndLineNumber() {
    for(Match it in brackets.allMatches(codeSegment)) {
      assert(it.groupCount == 0);
      if(it.group(0) == "{") {
        numberOfOpenBrackets++;
      } else if(it.group(0) == "}") {
        numberOfOpenBrackets--;
      }
      if(numberOfOpenBrackets == 0) {
        return it.start;
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