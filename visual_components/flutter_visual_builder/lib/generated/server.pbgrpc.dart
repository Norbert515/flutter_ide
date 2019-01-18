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
  static final _$getFields =
      new ClientMethod<GetFieldsRequest, GetFieldsResponse>(
          '/helloworld.Server/GetFields',
          (GetFieldsRequest value) => value.writeToBuffer(),
          (List<int> value) => new GetFieldsResponse.fromBuffer(value));
  static final _$streamUpdate = new ClientMethod<FieldUpdate, HelloReply>(
      '/helloworld.Server/StreamUpdate',
      (FieldUpdate value) => value.writeToBuffer(),
      (List<int> value) => new HelloReply.fromBuffer(value));
  static final _$streamSelected =
      new ClientMethod<SelectStream, SelectedWidgetWithProperties>(
          '/helloworld.Server/StreamSelected',
          (SelectStream value) => value.writeToBuffer(),
          (List<int> value) =>
              new SelectedWidgetWithProperties.fromBuffer(value));

  ServerClient(ClientChannel channel, {CallOptions options})
      : super(channel, options: options);

  ResponseFuture<HelloReply> initialize(InitializeFileRequest request,
      {CallOptions options}) {
    final call = $createCall(
        _$initialize, new $async.Stream.fromIterable([request]),
        options: options);
    return new ResponseFuture(call);
  }

  ResponseFuture<GetFieldsResponse> getFields(GetFieldsRequest request,
      {CallOptions options}) {
    final call = $createCall(
        _$getFields, new $async.Stream.fromIterable([request]),
        options: options);
    return new ResponseFuture(call);
  }

  ResponseFuture<HelloReply> streamUpdate($async.Stream<FieldUpdate> request,
      {CallOptions options}) {
    final call = $createCall(_$streamUpdate, request, options: options);
    return new ResponseFuture(call);
  }

  ResponseStream<SelectedWidgetWithProperties> streamSelected(
      SelectStream request,
      {CallOptions options}) {
    final call = $createCall(
        _$streamSelected, new $async.Stream.fromIterable([request]),
        options: options);
    return new ResponseStream(call);
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
    $addMethod(new ServiceMethod<GetFieldsRequest, GetFieldsResponse>(
        'GetFields',
        getFields_Pre,
        false,
        false,
        (List<int> value) => new GetFieldsRequest.fromBuffer(value),
        (GetFieldsResponse value) => value.writeToBuffer()));
    $addMethod(new ServiceMethod<FieldUpdate, HelloReply>(
        'StreamUpdate',
        streamUpdate,
        true,
        false,
        (List<int> value) => new FieldUpdate.fromBuffer(value),
        (HelloReply value) => value.writeToBuffer()));
    $addMethod(new ServiceMethod<SelectStream, SelectedWidgetWithProperties>(
        'StreamSelected',
        streamSelected_Pre,
        false,
        true,
        (List<int> value) => new SelectStream.fromBuffer(value),
        (SelectedWidgetWithProperties value) => value.writeToBuffer()));
  }

  $async.Future<HelloReply> initialize_Pre(
      ServiceCall call, $async.Future request) async {
    return initialize(call, await request);
  }

  $async.Future<GetFieldsResponse> getFields_Pre(
      ServiceCall call, $async.Future request) async {
    return getFields(call, await request);
  }

  $async.Stream<SelectedWidgetWithProperties> streamSelected_Pre(
      ServiceCall call, $async.Future request) async* {
    yield* streamSelected(call, (await request) as SelectStream);
  }

  $async.Future<HelloReply> initialize(
      ServiceCall call, InitializeFileRequest request);
  $async.Future<GetFieldsResponse> getFields(
      ServiceCall call, GetFieldsRequest request);
  $async.Future<HelloReply> streamUpdate(
      ServiceCall call, $async.Stream<FieldUpdate> request);
  $async.Stream<SelectedWidgetWithProperties> streamSelected(
      ServiceCall call, SelectStream request);
}
