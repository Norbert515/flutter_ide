

// TODO use string buffer for efficiency
class StringBuilder {


  StringBuffer stringBuffer = StringBuffer();

  int numberOfIndents = 0;


  void addIndent() {
    numberOfIndents++;
  }

  void removeIndent() {
    numberOfIndents--;
  }


  void append(String string) {
    stringBuffer.write(string);
  }

  void write(String string) {
    for(int i = 0; i < numberOfIndents; i++) {
      stringBuffer.write("   ");
    }
    stringBuffer.write(string);
  }


  @override
  String toString() {
    return stringBuffer.toString();
  }
}