///
//  Generated code. Do not modify.
//  source: server.proto
///
// ignore_for_file: non_constant_identifier_names,library_prefixes,unused_import

// ignore: UNUSED_SHOWN_NAME
import 'dart:core' show int, bool, double, String, List, Map, override;

import 'package:protobuf/protobuf.dart' as $pb;

enum Field_It {
  double, 
  align, 
  notSet
}

class Field extends $pb.GeneratedMessage {
  static const Map<int, Field_It> _Field_ItByTag = {
    1 : Field_It.double,
    2 : Field_It.align,
    0 : Field_It.notSet
  };
  static final $pb.BuilderInfo _i = new $pb.BuilderInfo('Field', package: const $pb.PackageName('helloworld'))
    ..a<DoubleField>(1, 'double', $pb.PbFieldType.OM, DoubleField.getDefault, DoubleField.create)
    ..a<AlignmentField>(2, 'align', $pb.PbFieldType.OM, AlignmentField.getDefault, AlignmentField.create)
    ..oo(0, [1, 2])
    ..hasRequiredFields = false
  ;

  Field() : super();
  Field.fromBuffer(List<int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Field.fromJson(String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Field clone() => new Field()..mergeFromMessage(this);
  Field copyWith(void Function(Field) updates) => super.copyWith((message) => updates(message as Field));
  $pb.BuilderInfo get info_ => _i;
  static Field create() => new Field();
  Field createEmptyInstance() => create();
  static $pb.PbList<Field> createRepeated() => new $pb.PbList<Field>();
  static Field getDefault() => _defaultInstance ??= create()..freeze();
  static Field _defaultInstance;
  static void $checkItem(Field v) {
    if (v is! Field) $pb.checkItemFailed(v, _i.qualifiedMessageName);
  }

  Field_It whichIt() => _Field_ItByTag[$_whichOneof(0)];
  void clearIt() => clearField($_whichOneof(0));

  DoubleField get double => $_getN(0);
  set double(DoubleField v) { setField(1, v); }
  bool hasDouble() => $_has(0);
  void clearDouble() => clearField(1);

  AlignmentField get align => $_getN(1);
  set align(AlignmentField v) { setField(2, v); }
  bool hasAlign() => $_has(1);
  void clearAlign() => clearField(2);
}

class DoubleField extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = new $pb.BuilderInfo('DoubleField', package: const $pb.PackageName('helloworld'))
    ..a<double>(1, 'value', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  DoubleField() : super();
  DoubleField.fromBuffer(List<int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  DoubleField.fromJson(String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  DoubleField clone() => new DoubleField()..mergeFromMessage(this);
  DoubleField copyWith(void Function(DoubleField) updates) => super.copyWith((message) => updates(message as DoubleField));
  $pb.BuilderInfo get info_ => _i;
  static DoubleField create() => new DoubleField();
  DoubleField createEmptyInstance() => create();
  static $pb.PbList<DoubleField> createRepeated() => new $pb.PbList<DoubleField>();
  static DoubleField getDefault() => _defaultInstance ??= create()..freeze();
  static DoubleField _defaultInstance;
  static void $checkItem(DoubleField v) {
    if (v is! DoubleField) $pb.checkItemFailed(v, _i.qualifiedMessageName);
  }

  double get value => $_getN(0);
  set value(double v) { $_setDouble(0, v); }
  bool hasValue() => $_has(0);
  void clearValue() => clearField(1);
}

class AlignmentField extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = new $pb.BuilderInfo('AlignmentField', package: const $pb.PackageName('helloworld'))
    ..a<double>(1, 'x', $pb.PbFieldType.OD)
    ..a<double>(2, 'y', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  AlignmentField() : super();
  AlignmentField.fromBuffer(List<int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  AlignmentField.fromJson(String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  AlignmentField clone() => new AlignmentField()..mergeFromMessage(this);
  AlignmentField copyWith(void Function(AlignmentField) updates) => super.copyWith((message) => updates(message as AlignmentField));
  $pb.BuilderInfo get info_ => _i;
  static AlignmentField create() => new AlignmentField();
  AlignmentField createEmptyInstance() => create();
  static $pb.PbList<AlignmentField> createRepeated() => new $pb.PbList<AlignmentField>();
  static AlignmentField getDefault() => _defaultInstance ??= create()..freeze();
  static AlignmentField _defaultInstance;
  static void $checkItem(AlignmentField v) {
    if (v is! AlignmentField) $pb.checkItemFailed(v, _i.qualifiedMessageName);
  }

  double get x => $_getN(0);
  set x(double v) { $_setDouble(0, v); }
  bool hasX() => $_has(0);
  void clearX() => clearField(1);

  double get y => $_getN(1);
  set y(double v) { $_setDouble(1, v); }
  bool hasY() => $_has(1);
  void clearY() => clearField(2);
}

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

