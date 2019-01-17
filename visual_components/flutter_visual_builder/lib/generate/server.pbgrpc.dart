///
//  Generated code. Do not modify.
//  source: server.proto
///
// ignore_for_file: non_constant_identifier_names,library_prefixes,unused_import

import 'dart:async' as $async;

import 'package:grpc/grpc.dart';

import 'server.pb.dart';
export 'server.pb.dart';

class ServerClient extends Client {
  static final _$initialize =
      new ClientMethod<InitializeFileRequest, HelloReply>(
          '/helloworld.Server/Initialize',
          (InitializeFileRequest value) => value.writeToBuffer(),
          (List<int> value) => new HelloReply.fromBuffer(value));

  ServerClient(ClientChannel channel, {CallOptions options})
      : super(channel, options: options);

  ResponseFuture<HelloReply> initialize(InitializeFileRequest request,
      {CallOptions options}) {
    final call = $createCall(
        _$initialize, new $async.Stream.fromIterable([request]),
        options: options);
    return new ResponseFuture(call);
  }
}

abstract class ServerServiceBase extends Service {
  String get $name => 'helloworld.Server';

  ServerServiceBase() {
    $addMethod(new ServiceMethod<InitializeFileRequest, HelloReply>(
        'Initialize',
        initialize_Pre,
        false,
        false,
        (List<int> value) => new InitializeFileRequest.fromBuffer(value),
        (HelloReply value) => value.writeToBuffer()));
  }

  $async.Future<HelloReply> initialize_Pre(
      ServiceCall call, $async.Future request) async {
    return initialize(call, await request);
  }

  $async.Future<HelloReply> initialize(
      ServiceCall call, InitializeFileRequest request);
}
