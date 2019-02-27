
# IDE

An IDE written in Flutter, for Flutter.



## Design goals


### Hackable

The IDE is written in and for Flutter, it should be possible
to write new custom development tools and UIs using Flutter.

This implies that the IDE API must be very flexible and easy to use.

_additional points if it's possible add code to the JIT compiler during
runtime or even hot reload while working on the code for the IDE inside the
IDE_

### Rock solid text editing (of course, also hackable)

XI looks like a very promising editor. I manged to make it run on
a bare Flutter App (without Fuchisa in it) on Desktop and mobile

### Cross Platform

Who said that IDEs are only made for PC? This IDE will run on:

- Linux/Mac/Windows/Fuchsia
- Android/ iOS
- The web
- Smart Tvs
- Raspberry Pi?! 
- Possibly even in your imagination once Neuralink figured that one out :)



