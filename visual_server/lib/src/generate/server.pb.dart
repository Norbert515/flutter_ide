///
//  Generated code. Do not modify.
//  source: server.proto
///
// ignore_for_file: non_constant_identifier_names,library_prefixes,unused_import

// ignore: UNUSED_SHOWN_NAME
import 'dart:core' show int, bool, double, String, List, Map, override;

import 'package:protobuf/protobuf.dart' as $pb;

class InitializeFileRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = new $pb.BuilderInfo('InitializeFileRequest', package: const $pb.PackageName('helloworld'))
    ..aOS(1, 'path')
    ..hasRequiredFields = false
  ;

  InitializeFileRequest() : super();
  InitializeFileRequest.fromBuffer(List<int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  InitializeFileRequest.fromJson(String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  InitializeFileRequest clone() => new InitializeFileRequest()..mergeFromMessage(this);
  InitializeFileRequest copyWith(void Function(InitializeFileRequest) updates) => super.copyWith((message) => updates(message as InitializeFileRequest));
  $pb.BuilderInfo get info_ => _i;
  static InitializeFileRequest create() => new InitializeFileRequest();
  InitializeFileRequest createEmptyInstance() => create();
  static $pb.PbList<InitializeFileRequest> createRepeated() => new $pb.PbList<InitializeFileRequest>();
  static InitializeFileRequest getDefault() => _defaultInstance ??= create()..freeze();
  static InitializeFileRequest _defaultInstance;
  static void $checkItem(InitializeFileRequest v) {
    if (v is! InitializeFileRequest) $pb.checkItemFailed(v, _i.qualifiedMessageName);
  }

  String get path => $_getS(0, '');
  set path(String v) { $_setString(0, v); }
  bool hasPath() => $_has(0);
  void clearPath() => clearField(1);
}

class HelloReply extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = new $pb.BuilderInfo('HelloReply', package: const $pb.PackageName('helloworld'))
    ..aOS(1, 'message')
    ..hasRequiredFields = false
  ;

  HelloReply() : super();
  HelloReply.fromBuffer(List<int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  HelloReply.fromJson(String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  HelloReply clone() => new HelloReply()..mergeFromMessage(this);
  HelloReply copyWith(void Function(HelloReply) updates) => super.copyWith((message) => updates(message as HelloReply));
  $pb.BuilderInfo get info_ => _i;
  static HelloReply create() => new HelloReply();
  HelloReply createEmptyInstance() => create();
  static $pb.PbList<HelloReply> createRepeated() => new $pb.PbList<HelloReply>();
  static HelloReply getDefault() => _defaultInstance ??= create()..freeze();
  static HelloReply _defaultInstance;
  static void $checkItem(HelloReply v) {
    if (v is! HelloReply) $pb.checkItemFailed(v, _i.qualifiedMessageName);
  }

  String get message => $_getS(0, '');
  set message(String v) { $_setString(0, v); }
  bool hasMessage() => $_has(0);
  void clearMessage() => clearField(1);
}

