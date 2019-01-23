# Flutter-IDE

An IDE for Flutter written in Flutter.


TODO insert 3D rendered mac with the Flutter-IDE running on it image.

TODO Flutter style "landing-page", short descriptive summary of this project.

Disclaimed: This is not an official Google product, I'm working on this in my free time.

## Uniqueness

### Stateful visual builder.

Work on the layout while keeping state.

### Drag and drop that produces quality code

Number one goal is not to replace coding layouts but enhance it.

### Building for different screens at the same time

Preview your live changes on as many different screen sizes as you want.

### Extensible and hackable

Don't want to use the Flutter-IDE but like the visual editor? Use the plugin!

Need new tools? Write a plugin for this IDE!



# Road-map

- Creating new layouts and exporting the source code.

- Tweaking values through the server

- Writing a lot of tests

- Building the basics IDE interface

- Integrating the XI-Editor & implementing Dart features (syntax highlighting, 
analysis, dartfm)

- Dynamically changing existing source code (using dart kernel transformers)

- Advanced layouting with CustomPainter, CustomMultiChildLayout

- Advanced layouting through different tools (snapping, absolute values/ 
percentages)

- IntelliJ and VSCode plugin for visual builder

- Getting a solid build system set up

- Set automated testing and building artifacts 

- Integrations test GUI (like espresso)

- Adding and managing packages with a GUI and a in-IDE browser

- Widget catalog (create a widget - publish it and drag and drop in a widget)

- Interactive layout tutorial (step by step guide to understanding layouts
and experimenting with it)

- Infer common widget usage (for example, when being in a Flex it adds the ability to change the expanded behavior without
explicitly wrapping it in a Expanded)

- Keyframing animations (like in AE or similar - it automatically generates animation code needed)

- Theme manager

- Loading background image with transparency to match design



## Module overview

### Visual Components

Are the building blocks for the visual editor. They themselves are not
execrable on their own. Rather they are used by the App-Linker to enable
visual editing.

### App-Linker

A server which handles all source code translations. Editing source values
goes through this server.

### The IDE, which contains all the IDE code.

