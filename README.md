# Flutter-IDE

An IDE for Flutter written in Flutter.


TK image and gifs.


## What is already done?

- A lot of research and trial and error
- Server client communication (you can run the actual app on a phone for instance 
and change properties on your work machine)
- A working implementation of the interactive widget builder (though, I think
there might be a better solution)
- Basic IDE architecture

## 1.0 features

- Having a file browser for the Flutter project
- Opening a file which contains a widget should open the visual builder
ready to change the widget. The source could should be updated each time a 
constant property is changed.
- All Flutter widgets should be available



## Challenges

First off, this is a pretty hard thing to implement correctly. In the following
section I want to talk about problems that need to be solved to make this work.


### Widget source code -> interactive builder

There are two things widgets which are displayed in the interactive builder 
can do which normal widgets can't and it's **being dragged** and 
**state being modified from external sources**.

### Code preservation 
When editing widgets the code is run (source code doesn't matter any longer). 
When converting back the runtime object to source code 


### State




## Solution ideas
I came up with a bunch of ideas and possible solutions for theses. In addition
I implemented a few features. Though, keep in mind, it is very experimental and things
are likely going to be need to be re written.


### Widget source code -> interactive builder


### Code preservation  


### State




## Module overview TK add more 

### Visual Components

Are the building blocks for the visual editor. They themselves are not
execrable on their own. Rather they are used by the App-Linker to enable
visual editing.

### App-Linker

A server which handles all source code translations. Editing source values
goes through this server.

### The IDE, which contains all the IDE code.




# Components

## Naming conventions

### Components
Each element which can be edited is called $NAME$Component, for example the wrapped
Text widget is called TextComponent.
(There might be a few classes named Visual$NAME$, this was the old naming and it will disappear over time)

### Property

Right now every property is called $NAME$Property, so for String it is a StringProperty.
Might be changed in the future because some names clash with flutters diagnostics.

### PropertyChanger

$NAME$Changer - StringChanger

# Creating a new editable property

## Creating new things

### Creating a new property

1. Creating the property class and updating the converter
2. Implementing the changer and returning it in the propertyBloc


### Creating a new widget

1. Using the "component" live-template
2. Creating a new BuildingBlock in "dynmaic_widget" returning it "editor_widget"

If the widget has children itself wrap each child in a LayoutDragTarget, assign it a final GlobalKey. Then
return each WidgetProperty


kernel-transformer:
Flutter repo - packages/tools/lib/src/compile.dart line 201 - starts engine-frontendserver

# State of this project


Visual widget building.

Next steps:

Building and polishing the very core. Once that is done, giving up the project is not a defeat.

The very core MVP:

- Improved UI and layout
- More value changers
- Better placeholder system
- Tree representation with drag& drop
- Column Expanded/Flexible


### Stateful visual builder.

Work on the layout while keeping state.

### Drag and drop that produces quality code

Number one goal is not to replace coding layouts but enhance it.

### Building for different screens at the same time

Preview your live changes on as many different screen sizes as you want.

### Extensible and hackable

Don't want to use the Flutter-IDE but like the visual editor? Use the plugin!

Need new tools? Write a plugin for this IDE!
