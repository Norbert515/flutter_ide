# flutter_ide

A Flutter-IDE proposal

## Table of contents

### How would Flutter be possible

Flutter will run everywhere. Currently, Flutter Desktop is not finished yet but it will...
It can also run on the Web and obviously phones. I could also run on a Raspbarry pi (So many posibillites).

Flutter is also pretty lightweight. It should work pretty well even on older machines.

...


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

I've explored this idea under the name "Live-Reload". Hot-Reload is blazingly fast, but it still needs to
compile code and upload the changes. Interactively changing, for example, the font size using a slider is not possible.

(https://github.com/Norbert515/flutter_experiment_phone_ide)

But because the IDE itself could have runtime access to the underlying code, all it would have to do is change
a value to a variable and then change the variable and schedule a rebuild. 

A few ideas how Live-Reload could be used:
- Changing basic values for rendering (width/height/color/font-size etc.) with a slider/color-picker
- Controlling/ Debugging an animation (even a hero animation) using a slider inside the IDE
- Injecting data into Streams during runtime for testing and debugging purposes

### Interactive rendering


### Plugin ideas

#### Json-Dart manager
Copy a json schema into the plugin. Instead of just converting the JSON to a Dart Object, it keeps the json
representation. You can then toggle between Dart-object/json reprenstation to make adjustments. Both are always in sync.

#### Curve-Adjustments 
Like https://googlesamples.github.io/web-fundamentals/fundamentals/design-and-ux/animations/curve-playground.html
but inside Flutter.

#### Local-Database viewer/ manipulator


### Writing the IDE

One of the biggest downsides to this project is, that most stuff will need to be done from scratch.
There is no fully implemented file system manager or code editor. 

But on the other hand, this could also be a chance to make it right and to make it fit very well with
the Flutter ecosystem.

Flutter is fast. Not only in terms of execution but also in development. Even though this is a gigantic project
I have no doubt that there can be actually useful features finished in a reasonable amount of time.

At first, it could be used for only a specific feature



- IDE has runtime access to the application (values can be changed with a slider in the IDE for example text size)
- Ios like storyboard with actual widget renders
- Lightweight
