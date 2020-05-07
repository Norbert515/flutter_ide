import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:widget_maker_2_0/data/bs/widget_board/widget_board.dart';
import 'package:widget_maker_2_0/data/widget_elements/generated/final_widget_converter.dart';
import 'package:widget_maker_2_0/data/widget_elements/wrappers/wrappers.dart';

WidgetBoard helloWorldTemplate() {
  var it = Scaffold(
    appBar: AppBar(
      title: Text("Hello World App"),
    ),
    body: Center(
      child: Text("Hello World!"),
    ),
    floatingActionButton: FloatingActionButton(
      onPressed: () {},
      child: Icon(Icons.add),
    ),
  );
  return WidgetElementDeserializer2.buildWidgetBoard(it);
}
WidgetBoard testTemplate() {

  var it = Material(
    textStyle: TextStyle(
      fontFamily: "Roboto Slab",
    ),
    child: Form(
      autovalidate: true,
      child: Padding(
        padding: EdgeInsets.symmetric(),
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Hello There",
                      style: TextStyle(fontSize: 34.0, color: const Color(0xffD11E48)),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Text(
                      "Please sign in to continue",
                      style: TextStyle(fontSize: 18.0, color: const Color(0xff5B5B5B)),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      scrollPadding: EdgeInsets.only(bottom: 120.0),
                      decoration: InputDecoration(labelText: "Username"),
                    ),
                    SizedBox(
                      height: 32.0,
                    ),
                    TextFormField(
                      scrollPadding: EdgeInsets.only(bottom: 140.0),
                      decoration: InputDecoration(labelText: "Password"),
                      obscureText: true,
                    ),
                    SizedBox(
                      height: 12.0,
                    ),
                    Align(alignment: Alignment.center, child: Text("Forgot Password?")),
                    SizedBox(
                      height: 32.0,
                    ),
                    FloatingActionButton(
                      onPressed: () {},
                      child: Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      ),
                      elevation: 0.0,
                      backgroundColor: const Color(0xffD11E48),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: WContainer(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: GestureDetector(
                  onTap: () {},
                  child: Text(
                    "Sign up, if you're new",
                    style: TextStyle(fontSize: 18.0, color: const Color(0xff5B5B5B), inherit: true),
                  ),
                ),
              )
            ),
          ],
        ),
      ),
    ),
  );
  return WidgetElementDeserializer2.buildWidgetBoard(it);
}
