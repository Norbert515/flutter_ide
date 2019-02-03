import 'package:flutter/material.dart';
import 'package:flutter_visual_builder/editor/widget_palette/palette_items.dart';
import 'package:ide/themeing/ide_theme.dart';
import 'package:ide/ui/home_page.dart';

/// Navigator.of(context).push(FadeRoute(
///   builder: (context) {
///     return NewPage();
///   }
/// ));
class FadeRoute extends PageRoute {

  FadeRoute({@required this.builder});

  final WidgetBuilder builder;

  @override
  Color get barrierColor => null;

  @override
  String get barrierLabel => null;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    return new FadeTransition(
      opacity: animation,
      child: builder(context),
    );
  }

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 300);
}

class TutorialWelcome extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Thank you for trying out this tech-demo of Widget Maker! \n\n"
        "the following pages contain a mini tutorial walking though the very basics, \n"
            "this won't take longer than one minute"),
      ),
      floatingActionButton: OutlineButton(onPressed: (){
        Navigator.of(context).push(FadeRoute(
          builder: (_) => TutorialDisclaimer(),
        ));
      }, child: Text("Next"),),
    );
  }
}

class TutorialDisclaimer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Disclaimer: \n\n"
            "A lot of stuff is missing, especially widgets\n"
            "that's because I'm still refining the architecture "
            "and less widgets mean less work for the time being. New widgets don't take very\n"
        "long to implement so expect more of them coming soon.\n"
            "You also might encounter a few bugs, feel free to report them to me."),
      ),
      floatingActionButton: Row(
        children: <Widget>[
          Spacer(),
          OutlineButton(onPressed: (){
            Navigator.of(context).pushReplacement(FadeRoute(
              builder: (_) => HomePage(),
            ));
          }, child: Text("Skip tutorial"),),
          OutlineButton(onPressed: (){
            Navigator.of(context).push(FadeRoute(
              builder: (_) => TutorialPlaceholder(),
            ));
          }, child: Text("Next"),),
        ],
      ),
    );
  }
}

class TutorialPlaceholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("These: "),
            SizedBox(height: 8,),
            SizedBox(width:100, height:100,child: Placeholder()),
            SizedBox(height: 8,),
            Text("are placeholder for widgets. Every possible drag location is marked with one.")
          ],
        ),
      ),
      floatingActionButton: OutlineButton(onPressed: (){
        Navigator.of(context).push(FadeRoute(
          builder: (_) => TutorialDraggableItem(),
        ));
      }, child: Text("Next"),),
    );
  }
}

class TutorialDraggableItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Draggable widget are located at the left and look like this:"),
            SizedBox(height: 8,),
            SizedBox(
              height: 60,
              width: 200,
              child: Material(
                color: IDETheme.of(context).lightBackground,
                child: PaletteItem(
                  name: "Container",
                  icon: Icon(Icons.check_box_outline_blank),
                ),
              ),
            ),
            SizedBox(height: 8,),
            Text("Just drag them into the placeholders"),
          ],
        ),
      ),
      floatingActionButton: OutlineButton(onPressed: (){
        Navigator.of(context).push(FadeRoute(
          builder: (_) => TutorialPropertyPage(),
        ));
      }, child: Text("Next"),),
    );
  }
}
class TutorialPropertyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Tap widgets on the screen to access the property editor"),
      ),
      floatingActionButton: OutlineButton(onPressed: (){
        Navigator.of(context).pushReplacement(FadeRoute(
          builder: (_) => HomePage(),
        ));
      }, child: Text("Let's go!"),),
    );
  }
}



