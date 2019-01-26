# Visual Server

This module contains the server and a dart client for this server.

It is using gRPC.

# deprecated, will be removed soon

## Usage

**Using the managed version:**

Start up the server:
 
```
dart <path_to_this_project>\bin\managed_server.dart --deviceId = "Desktop"
```

Arguments:

- deviceId
- width
- height

this will launch the a new layout builder on the selected device. 

Using the client:

Add this project to your dependencies:
```
visual_client: any
```



## Structure

The client contains all the code needed to interact with the running instance.

Managed_instance only exposes methods to read and set values of widgets, whereby 
raw_widget also returns a widget which can be included in an app.


## Client

The client supports two different use cases. It can either return a 
fully connected and set up widget which can be directly used.

Or it can start up and manage a separate Flutter instance. In this cause
is is possible to choose the medium it should run Flutter on (Desktop or
any mobile phone).
