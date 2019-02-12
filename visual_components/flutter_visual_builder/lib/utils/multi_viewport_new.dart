import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/foundation.dart'
    show AbstractNode, debugDefaultTargetPlatformOverride;
import 'package:flutter_visual_builder/utils/multi_viewport.dart';
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
       child: Test123(
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

class Test123 extends CustomStuffWidget {

  Test123({Widget child}) : super(child: child);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderTest();
  }

}

class RenderTest extends RenderProxyBox{


  Offset localOffset;


  @override
  void paint(PaintingContext context, Offset offset) {
    if (child != null) {
      context.paintChild(child, Offset(0,0));
    }
  }
}

abstract class CustomStuffWidget extends RenderObjectWidget {
  /// Initializes fields for subclasses.
  ///
  /// The [children] argument must not be null and must not contain any null
  /// objects.
  CustomStuffWidget({ Key key, this.child }) :super(key: key);

  /// The widgets below this widget in the tree.
  ///
  /// If this list is going to be mutated, it is usually wise to put [Key]s on
  /// the widgets, so that the framework can match old configurations to new
  /// configurations and maintain the underlying render objects.
  final Widget child;


  @override
  CustomElementStuff  createElement() => CustomElementStuff(this);
}


class CustomElementStuff extends RenderObjectElement {
  /// Creates an element that uses the given widget as its configuration.
  CustomElementStuff(CustomStuffWidget  widget) :super(widget);

  @override
  CustomStuffWidget get widget => super.widget;

  /// The current list of children of this element.
  ///
  /// This list is filtered to hide elements that have been forgotten (using
  /// [forgetChild]).
  @protected
  Iterable<Element> get children => _children;

  List<Element> _children;

  @override
  void insertChildRenderObject(RenderObject child, Element slot) {
    final RenderObjectWithChildMixin<RenderObject> renderObject = this.renderObject;
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
  //  final ContainerRenderObjectMixin<RenderObject, ContainerParentDataMixin<RenderObject>> renderObject = this.renderObject;
  //  assert(child.parent == renderObject);
  //  renderObject.remove(child);
  //  assert(renderObject == this.renderObject);
  }

  @override
  void visitChildren(ElementVisitor visitor) {
    for (Element child in _children) {
    visitor(child);
    }
  }

  @override
  void forgetChild(Element child) {
    assert(_children.contains(child));
  }

  @override
  void mount(Element parent, dynamic newSlot) {
    super.mount(parent, newSlot);
    _children = List<Element>(4);
    Element previousChild;
    for (int i = 0; i < _children.length; i += 1) {
      final Element newChild = inflateWidget(widget.child, previousChild);
      (newChild.renderObject as RenderMultiView).localOffset = Offset(100.0 * i, 100.0 * i);
      _children[i] = newChild;
      previousChild = newChild;
    }
  }

  @override
  void update(CustomStuffWidget  newWidget) {
    super.update(newWidget);
    assert(widget == newWidget);
    //_children = updateChildren(_children, widget.children);
  }
}