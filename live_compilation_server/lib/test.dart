import 'package:flutter/material.dart';

Widget buildL() {
   return Scaffold(
      appBar: AppBar(
         title: Text("Hello!",),
      ),
      body: Center(
         child: Container(
            child: Text("Text",),
            alignment: Alignment.center,
            color: Color(4290068287),
            padding: EdgeInsets.all(0.0),
         ),
      ),
      floatingActionButton: FloatingActionButton(
      ),
   );
}
