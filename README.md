# Flutter-IDE

An IDE for Flutter written in Flutter.


# State of this project

I'm unsure. Every feature I thought about builds on one core premise.

Visual widget building.

Next steps:

Building and polishing the very core. Once that is done, giving up the project is not a defeat.

The very core MVP:

- Improved UI and layout
- More value changers
- Better placeholder system
- Tree representation with drag& drop
- Column Expanded/Flexible


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




## Module overview

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