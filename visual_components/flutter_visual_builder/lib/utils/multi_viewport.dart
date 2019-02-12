import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';


import 'package:flutter/foundation.dart'
    show AbstractNode, debugDefaultTargetPlatformOverride;
void main() {
  debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Flutter Demo Home Page'),
      ),
      body: new Center(
       child: MultiView(
         child: Container(
           height: 200,
           width: 200,
           margin: EdgeInsets.all(16),
           padding: EdgeInsets.all(16),
           color: Colors.pink.withOpacity(0.5),
           child: MyStuff(),
         ),
       ),
      ),
    );
  }
}


class MyStuff extends StatefulWidget {
  @override
  _MyStuffState createState() => new _MyStuffState();
}

class _MyStuffState extends State<MyStuff> {

  int count = 0;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Text("Count: $count"),
        RaisedButton(
          onPressed: () {
            setState(() {
              count++;
            });
          },
          child: Text("Press me"),
        ),
      ],
    );
  }
}



// TODO put this into a separate package
class MultiView extends SingleChildRenderObjectWidget {

  MultiView({Key key, Widget child}): super(key: key, child: child);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderMultiView();
  }

}


class RenderMultiView extends RenderProxyBox {


  Offset localOffset;

  @override
  void performLayout() {
    size = Size(500, 500);
    child.layout(constraints);
    /*if (child != null) {
      child.layout(constraints, parentUsesSize: true);
      size = child.size;
    } else {
      performResize();
    }*/
  }


  @override
  void paint(PaintingContext context, Offset offset) {
    if (child != null) {
    //  child.layout(BoxConstraints.tight(Size(250, 250)));
     // context.canvas.drawRect(Rect.fromPoints(offset, offset + Offset(500, 500)), Paint()..color = Colors.yellow);
   //   context.paintChild(child, offset);

   /*   RenderConstrainedBox(
        additionalConstraints: BoxConstraints(
          maxWidth: 50,
          maxHeight: 50
        ),
        child: this
      )..performLayout()
       ..paint(context, offset);*/

    //  child.layout(BoxConstraints.tight(Size(230, 80)));



      context.paintChild(child, localOffset);
    }
  }


}



abstract class CopiedRenderObjectWidget extends RenderObjectWidget {
  /// Abstract const constructor. This constructor enables subclasses to provide
  /// const constructors so that they can be used in const expressions.
  const CopiedRenderObjectWidget({ Key key, this.child }) : super(key: key);

  /// The widget below this widget in the tree.
  ///
  /// {@macro flutter.widgets.child}
  final Widget child;

  @override
  CopiedRenderObjectElement createElement() => CopiedRenderObjectElement(this);
}


class CopiedRenderObjectElement extends RenderObjectElement {
  /// Creates an element that uses the given widget as its configuration.
  CopiedRenderObjectElement(CopiedRenderObjectWidget widget) : super(widget);

  @override
  CopiedRenderObjectWidget get widget => super.widget;

  Element _child;
  Element _child2;

  @override
  void visitChildren(ElementVisitor visitor) {
    if (_child != null)
      visitor(_child);
    if (_child2 != null)
      visitor(_child2);

  }

  @override
  void forgetChild(Element child) {
    assert(child == _child);
    _child = null;
    _child2 = null;
  }

  @override
  void mount(Element parent, dynamic newSlot) {
    super.mount(parent, newSlot);
    _child = updateChild(_child, widget.child, null);
    _child2 = updateChild(_child2, Container(height: 150, width: 150, color: Colors.blue), null);
  }



  @override
  void update(SingleChildRenderObjectWidget newWidget) {
    super.update(newWidget);
    assert(widget == newWidget);
    _child = updateChild(_child, widget.child, null);
    _child2 = updateChild(_child2, widget.child, null);
  }

  @override
  void insertChildRenderObject(RenderObject child, dynamic slot) {
    final RenderObjectWithChildMixin<RenderObject> renderObject = this.renderObject;
    assert(slot == null);
    assert(renderObject.debugValidateChild(child));
    renderObject.child = child;
    assert(renderObject == this.renderObject);
  }

  @override
  void moveChildRenderObject(RenderObject child, dynamic slot) {
    assert(false);
  }

  @override
  void removeChildRenderObject(RenderObject child) {
    final RenderObjectWithChildMixin<RenderObject> renderObject = this.renderObject;
    assert(renderObject.child == child);
    renderObject.child = null;
    assert(renderObject == this.renderObject);
  }
}