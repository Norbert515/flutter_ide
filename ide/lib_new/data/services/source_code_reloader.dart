import 'dart:async';
import 'package:http/http.dart' as http;

class SourceCodeReloader {



  Future reloadSourceCode() {
    return http.get("http://localhost:4040");
  }
}