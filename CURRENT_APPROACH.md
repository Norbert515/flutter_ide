
# Current Approach



## Basic idea

Each widget has a visual-widget counterpart. The visual-widget takes
the same arguments as the original widget (in addition to some meta data
which is discussed later).

```dart

Scaffold(
  body: Text("Hi")
);

VisualScaffold(
  body: Text("Hi")
);

```

The visual-widgets are intended to be as simple and as close to the original as
possible, as it should be possible to auto generate them later on. 
Visual widgets also provide a way to modify the interaction during 
visual editing (for example a Column needs a bit of tweaking to provide a
good UX).

### Starting from blank

Each widget which is dragged in is a visual-widget. It registered its
properties and children to the system and is ready to receive new children
and property updates. 

Each time something is modified the tree is converted to the source code
string. Each visual-widget recursively adds its source code by taking its
class name and passing all the present values as properties.

Starting from blank is already implemented but there are a bunch of things
to consider, therefore this might get refactored at some point.


### Starting from existing source code

This is where stuff becomes interested. Starting from a blank canvas
is already super cool, but it's even cooler when opening up a preexisting 
widget and changing stuff.


#### Current idea 

The goal is to convert a standard widget to a visual-widget.

This:
```dart
Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Text"),
      ),
    );
  }
```

to this:

```dart
Widget build(BuildContext context) {
    return VisualScaffold(
      body: VisualCenter(
        child: VisualText("Text"),
      ),
    );
  }
```

1. Naive approach: RegEx

This example would certainly be possible to parse via regex, but regex would 
probably fail miserably once things become more complex.

##### Dart Kernel Transformers

Check out this article if you want to learn more about the dart VM: https://mrale.ph/dartvm/
 

Brief overview of what it is:
WHen compiling dart code, it is first compiled to something called 
"dart kernel binaries" (those are the .dill files you see when you look
into a compiles dart project). This "language" is then handed to the VM for execution.







#### Alternative ideas

An alternative idea could be to write all this code into the Flutter
framework itself. Therefore the `Center` widget could have some switch inside
which changes it from a regular widget to a visual-widget.

This would eliminate the need of having to convert widgets to something else.

It would even be possible to compile apps inside to IDE against the modified
Flutter source code, therefore not needing the user to have two separate
Flutters installed.

But this also has a few downsides:

- There would need to be quite a few changes to internal widget behaviour, which
    could cause merge conflicts on newer Flutter versions and an overall harder
    development experience.
- It wouldn't be so easy to iteratively add new widgets.