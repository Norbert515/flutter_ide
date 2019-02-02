

import 'package:flutter/material.dart';

class TutorialWelcome extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Thank you for trying out this tech-demo of Widget Maker! \n\n"
        "the following pages contain a mini tutorial walking though the very basics, \n"
            "this won't take longer than one minute"),
      ),
      floatingActionButton: OutlineButton(onPressed: (){}, child: Text("Next"),),
    );
  }
}

class Disclaimer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text("Disclaimer: \n"
          "A lot of stuff is missing, especially widgets\n"
          "that's because I'm still refining the architecture "
          "and less widgets mean less work for the time being. New widgets don't take very\n"
      "long to implement so expect more of them coming soon.\n"
          "You also might encounter a few bugs, feel free to report them to me."),
    );
  }
}

class PlaceholderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class DraggableItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
class PropertyPageTutorial extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}



