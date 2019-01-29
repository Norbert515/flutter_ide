

// TODO use string buffer for efficiency
class StringBuilder {


  String buffer = "";

  int numberOfIndents = 0;


  void addIndent() {
    numberOfIndents++;
  }

  void removeIndent() {
    numberOfIndents--;
  }


  // TODO make this better
  // TODO do something like "write new line" which does the indent
  void writeNoIndent(String string) {
    buffer += string;
  }

  void write(String string) {
    String indent = "";
    for(int i = 0; i < numberOfIndents; i++) {
      indent += "   ";
    }
    buffer += indent + string;
  }


  @override
  String toString() {
    return buffer;
  }
}