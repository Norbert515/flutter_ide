# flutter_visual_builder

The widgets which the source gets transformed to.

## Usage in the IDE

The IDE is build as a collection of microservices. This makes for great
extensibillity especially, it allows to integrate different services in other
IDEs using plugins.

These are the components:

- The IDE itself is written in Flutter and hosts the editor and general IDE
features.

- The Dart-Analysis Server

- The Observatory

- The standalone running application. This is inside a new process, meaning there
is no runtime access to it. 
It can be started in a different window, on a phone or even embedded into the
IDE using the same technique as the WebView and Maps plugin.

- The App-Link is the bridge between the running app and the IDE. It is a server
which runs on the local machine. It has following tasks:

    - Convert the original source code into the modified source code which
    is used by the Visual-Builder (always have it as a copy so nothing can be lost)
    
    - Convert the modified source code back to the original
    
    - Handle live updates. If something is changed in the visual editor, it should
    be reflect in the code at the same time. This is also true if the code is changed
    the app should reflect those changes.



# New Discovery

The widget inspector does something very similar. 
Using a Dart Kernel Transformer you can hook yourself into the compilation and change source code.
/// [Dart Kernel Transformer](https://github.com/dart-lang/sdk/wiki/Kernel-Documentation).

The widget inspector does this for example when adding the file path and line number to widgets.

More links: https://github.com/flutter/engine/blob/master/frontend_server/lib/server.dart

Here is the actual transformer code:

https://github.com/flutter/engine/blob/70a1106b509ea3f34febca59967ed7a76c05ce33/flutter_kernel_transformers/lib/track_widget_constructor_locations.dart

Dart Kernel:

https://github.com/flutter/engine/blob/70a1106b509ea3f34febca59967ed7a76c05ce33/flutter_kernel_transformers/pubspec.yaml