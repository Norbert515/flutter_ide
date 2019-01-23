# ide

A Flutter IDE wirtten in Flutter


## Value-Changers structure

Each property has a corresponding value changer.

For example, a double might have a TextInputField, an alignment might have a 2D box with a pixel in it and a color
might have a color chooser.

Each value changer has a uniform signature to make it decoupled and easy to reuse.

- It takes in a value of its corresponding type
- It provides a ValueChanged callback with its corresponding type

Notes:
The widget must maintain its own state but also must accept values from the outside in didUpdateWidget.


## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.io/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.io/docs/cookbook)

For help getting started with Flutter, view our 
[online documentation](https://flutter.io/docs), which offers tutorials, 
samples, guidance on mobile development, and a full API reference.
