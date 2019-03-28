import 'dart:io';

/// Handles code modification of the the IDE itself.
///
/// This is only used for a POC, later on additional Flutter code will
/// be loaded in though a completely new OpenGL context (via surface textures)
class IdeSourceCodeModifier {



  void writeWidget(String widgetSourceCode) {
    Directory currentDirectory = Directory.current;
    print("Current directory path: ${currentDirectory.path}");
  }

}