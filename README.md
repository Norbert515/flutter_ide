# A Flutter-IDE proposal.

**Flutter is already super fast to develop with, but I have a vision that developing Apps of any kind can be even faster**

I won't go too deep into the technicalities in this very first draft. I just want to get the point across the table
and see if this, at its very core, makes sense. If people are interested in the idea, I will follow this up with
more technical ideas.

## How would Flutter as an IDE be possible to begin with

Flutter runs everywhere. 

Flutter Desktop is not finished yet and so isn't Hummingbird (Flutter Web) but a lot has happend in the last few months and a lot will happen this year.

Fun fact: it could also run on a Raspbarry-Pi (https://medium.com/flutter-io/flutter-on-raspberry-pi-mostly-from-scratch-2824c5e7dcb1).

With Flutter, building beautiful UIs in a reasonable amount of time becomes possible. With Dart, which is an awesome language, building large scale software becomes fun, contrary to other languages (looking at you JS).

Flutter is also pretty lightweight. It should work pretty well even on older machines.

## The advantages of using Flutter

### Plugins for a Flutter based IDE would be written in Flutter (obviously)

Why is this great?

Flutter developers know Flutter. This means the entry barrier to creating a plugin is very low. 

In addition, because this is Flutter - creating intuitive and beautiful UI's for the plugin is easier
than ever before.

Both of these properties have the following result:
- Developers can quickly create a plugin for themselves before first learning something completely new.
- More plugins are being developed and the ecosystem can quickly grow.

### IDE can have runtime access to the App

Before taking a look how this could be implemented, let's explore why this could potentially be a huge thing.

Runtime access means that the IDE not only has access to the source code, which is then compiled to machine
code, but also the complete state/ variables while the app is running.

![font_size](https://github.com/Norbert515/flutter_ide/assets/font_size_cut.mp4)
![font_size](https://github.com/Norbert515/flutter_ide/assets/material_color_cut.mp4)

I've explored this idea under the name "Live-Reload". Hot-Reload is blazingly fast, but it still needs to
compile code and upload the changes. Interactively changing, for example, the font size using a slider is not possible.

(https://github.com/Norbert515/flutter_experiment_phone_ide)

But because the IDE itself could have runtime access to the underlying code, all it would have to do is change
a value to a variable and then change the variable and schedule a rebuild. 

A few ideas how Live-Reload could be used:
- Changing basic values for rendering (width/height/color/font-size etc.) with a slider/color-picker
- Controlling/ Debugging an animation (even a hero animation) using a slider inside the IDE
- Injecting data into Streams during runtime for testing and debugging purposes

![font_size](https://github.com/Norbert515/flutter_ide/assets/color_cut.mp4)


#### How this could be implemented

##### Multiple Flutter instances running through one engine

Flutter Desktop is currently being developed and one tricky bit is supporting multiple Windows in one Flutter App.
Without going into the details, splitting up the way code is run versus how it is displayed would possibly allow to have multiple Flutter instances running which are accessing the same code.

##### As showcased in my experiments

It could also utilize the hot-reload and source code manipulation trick which I used for the prototype.

#### Isn't IntelliJ already doing this?
Yes and no. IntelliJ has way to communicate with the runtime, but they are pretty restircted and hard to set up.
IntelliJ can send messages to the dart vm which then gets passed to Flutter through the Flutter-engine. 


### Interactive rendering

Because the IDE is Flutter, widgets from the app can be rendered inside the IDE.

#### Working on isolated widgets

Instead of first creating a page and putting the widget in there. You could select the widget in code and open
a widget-renderer. Then, while changing the code, you can hot reload that single widget, or make it so it reloads
automatically.

This could especially be useful for widgets which take in data, which you'd first have to mock out. In the IDE you could
provide the data to use and even change it (using Live-Reload). Think about a text card where you want to fine tune
the behaviour with different text sizes.

#### Storyboards

Again, Flutter can render the pages (they are only widget).

What needs to be done is:

#### Figuring out the connections between the pages

The problem is, that routes can be pushed from anywhere and in a lot of possible ways.

Creating a well structured way of pushing page routes which makes it easy to understand for a computer would 
probably be the easiest solution.


#### Figuring out how to render a page

The problem is, that pages can depend on all sorts of data. Data can either be passed to the page, the page can
depend on an `InheritedWidget` or it could even depend on some static/ global variables.

There are a couple of ways to solve this problem. But again, having a well structured page class which handles
default parameters (for rendering in the IDE), would probably be the easiest solution.

## Layout-Editor

When switching into layout mode, the current page could display all slots where widgets could be dropped into. 
For exmaple a `Column` would expose a slot at the top of the first widget and beneath the last widget. A scaffold could expose the 
FAB slot and so on.

Then all default widgets and custom widgets would be displayed in a list, ready to drag in. 
When this happens, the source code is changed.

## Plugin ideas

### Json-Dart manager
Copy a json schema into the plugin. Instead of just converting the JSON to a Dart Object, it keeps the json
representation. You can then toggle between Dart-object/json reprenstation to make adjustments. Both are always in sync.

### Curve-Adjustments 
Like https://googlesamples.github.io/web-fundamentals/fundamentals/design-and-ux/animations/curve-playground.html
but inside Flutter.

### Local-Database viewer/ manipulator


## Writing the IDE

One of the biggest downsides to this project is, that most stuff will need to be done from scratch.
There is no fully implemented file system manager or code editor. 

But on the other hand, this could also be a chance to make it right and to make it fit very well with
the Flutter ecosystem.

Flutter is fast. Not only in terms of execution but also in development. Even though this is a gigantic project
I have no doubt that there can be actually useful features finished in a reasonable amount of time.

Even if writing a complete IDE in Flutter might be too much, I'm confident that there are development tools that could be written in Flutter which provide real value.

For example having a Flutter app called Widget Maker, which interactively helps building widgets.



