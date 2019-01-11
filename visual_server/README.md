# Visual Server

This module contains the server and a dart client for this server.

It is using gRPC.

## Client

The client supports two different use cases. It can either return a 
fully connected and set up widget which can be directly used.

Or it can start up and manage a separate Flutter instance. In this cause
is is possible to choose the medium it should run Flutter on (Desktop or
any mobile phone).
