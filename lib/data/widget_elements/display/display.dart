import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:widget_maker_2_0/data/widget_elements/widgets/list_helpers.dart';



class DAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 56,
        child: AppBar(
          leading: Icon(Icons.arrow_back),
          title: Text("My App"),
        ),
      ),
    );
  }
}

class DText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit.", textAlign: TextAlign.center,);
  }
}


class DCenter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("This is centered"),
    );
  }
}

class DCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      height: 120,
      child: Card(
        color: Colors.white,
      ),
    );
  }
}

class DMaterialButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {},
      child: Text("MaterialButton"),
    );
  }
}

class DOutlineButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OutlineButton(
      onPressed: () {},
      child: Text("Outline Button"),
    );
  }
}

class DRaisedButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: () {},
      child: Text("Raised Button"),
    );
  }
}

class DCupertinoButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: () {},
      child: Text("Cupertino Button"),
    );
  }
}


class DScaffold extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FittedBox(
        child: SizedBox(
          width: 411,
          height: 731,
          child: Scaffold(
      appBar: AppBar(
          title: Text("My App"),
      ),
      body: Center(
          child: Text("Hello"),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
      ),
    ),
        ));
  }
}

class DColumn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 100,
      child: Arrow(
        color: Colors.white,
        axis: Axis.vertical,
      ),
    );
  }
}

class DRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 100,
      child: Arrow(
        color: Colors.white,
        axis: Axis.horizontal,
      ),
    );
  }
}

class DCheckbox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: true,
      onChanged: (_) {},
    );
  }
}


class DRotatedBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RotatedBox(
      child: Text("Im rotated!"),
      quarterTurns: 3,
    );
  }
}

class DFloatingActionButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {},
      child: Icon(Icons.add),
    );
  }
}
