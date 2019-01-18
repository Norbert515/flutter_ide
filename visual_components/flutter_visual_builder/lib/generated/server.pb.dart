///
//  Generated code. Do not modify.
//  source: server.proto
///
// ignore_for_file: non_constant_identifier_names,library_prefixes,unused_import

// ignore: UNUSED_SHOWN_NAME
import 'dart:core' show int, bool, double, String, List, Map, override;

import 'package:protobuf/protobuf.dart' as $pb;

class FieldUpdate extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = new $pb.BuilderInfo('FieldUpdate', package: const $pb.PackageName('helloworld'))
    ..a<Field>(1, 'field_1', $pb.PbFieldType.OM, Field.getDefault, Field.create)
    ..aOS(2, 'id')
    ..hasRequiredFields = false
  ;

  FieldUpdate() : super();
  FieldUpdate.fromBuffer(List<int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  FieldUpdate.fromJson(String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  FieldUpdate clone() => new FieldUpdate()..mergeFromMessage(this);
  FieldUpdate copyWith(void Function(FieldUpdate) updates) => super.copyWith((message) => updates(message as FieldUpdate));
  $pb.BuilderInfo get info_ => _i;
  static FieldUpdate create() => new FieldUpdate();
  FieldUpdate createEmptyInstance() => create();
  static $pb.PbList<FieldUpdate> createRepeated() => new $pb.PbList<FieldUpdate>();
  static FieldUpdate getDefault() => _defaultInstance ??= create()..freeze();
  static FieldUpdate _defaultInstance;
  static void $checkItem(FieldUpdate v) {
    if (v is! FieldUpdate) $pb.checkItemFailed(v, _i.qualifiedMessageName);
  }

  Field get field_1 => $_getN(0);
  set field_1(Field v) { setField(1, v); }
  bool hasField_1() => $_has(0);
  void clearField_1() => clearField(1);

  String get id => $_getS(1, '');
  set id(String v) { $_setString(1, v); }
  bool hasId() => $_has(1);
  void clearId() => clearField(2);
}

enum Field_It {
  double, 
  align, 
  color, 
  notSet
}

class Field extends $pb.GeneratedMessage {
  static const Map<int, Field_It> _Field_ItByTag = {
    1 : Field_It.double,
    2 : Field_It.align,
    3 : Field_It.color,
    0 : Field_It.notSet
  };
  static final $pb.BuilderInfo _i = new $pb.BuilderInfo('Field', package: const $pb.PackageName('helloworld'))
    ..a<DoubleField>(1, 'double', $pb.PbFieldType.OM, DoubleField.getDefault, DoubleField.create)
    ..a<AlignmentField>(2, 'align', $pb.PbFieldType.OM, AlignmentField.getDefault, AlignmentField.create)
    ..a<ColorField>(3, 'color', $pb.PbFieldType.OM, ColorField.getDefault, ColorField.create)
    ..oo(0, [1, 2, 3])
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

  ColorField get color => $_getN(2);
  set color(ColorField v) { setField(3, v); }
  bool hasColor() => $_has(2);
  void clearColor() => clearField(3);
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

class ColorField extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = new $pb.BuilderInfo('ColorField', package: const $pb.PackageName('helloworld'))
    ..a<int>(1, 'color', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  ColorField() : super();
  ColorField.fromBuffer(List<int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ColorField.fromJson(String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ColorField clone() => new ColorField()..mergeFromMessage(this);
  ColorField copyWith(void Function(ColorField) updates) => super.copyWith((message) => updates(message as ColorField));
  $pb.BuilderInfo get info_ => _i;
  static ColorField create() => new ColorField();
  ColorField createEmptyInstance() => create();
  static $pb.PbList<ColorField> createRepeated() => new $pb.PbList<ColorField>();
  static ColorField getDefault() => _defaultInstance ??= create()..freeze();
  static ColorField _defaultInstance;
  static void $checkItem(ColorField v) {
    if (v is! ColorField) $pb.checkItemFailed(v, _i.qualifiedMessageName);
  }

  int get color => $_get(0, 0);
  set color(int v) { $_setSignedInt32(0, v); }
  bool hasColor() => $_has(0);
  void clearColor() => clearField(1);
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

class GetFieldsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = new $pb.BuilderInfo('GetFieldsRequest', package: const $pb.PackageName('helloworld'))
    ..aOS(1, 'id')
    ..hasRequiredFields = false
  ;

  GetFieldsRequest() : super();
  GetFieldsRequest.fromBuffer(List<int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  GetFieldsRequest.fromJson(String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  GetFieldsRequest clone() => new GetFieldsRequest()..mergeFromMessage(this);
  GetFieldsRequest copyWith(void Function(GetFieldsRequest) updates) => super.copyWith((message) => updates(message as GetFieldsRequest));
  $pb.BuilderInfo get info_ => _i;
  static GetFieldsRequest create() => new GetFieldsRequest();
  GetFieldsRequest createEmptyInstance() => create();
  static $pb.PbList<GetFieldsRequest> createRepeated() => new $pb.PbList<GetFieldsRequest>();
  static GetFieldsRequest getDefault() => _defaultInstance ??= create()..freeze();
  static GetFieldsRequest _defaultInstance;
  static void $checkItem(GetFieldsRequest v) {
    if (v is! GetFieldsRequest) $pb.checkItemFailed(v, _i.qualifiedMessageName);
  }

  String get id => $_getS(0, '');
  set id(String v) { $_setString(0, v); }
  bool hasId() => $_has(0);
  void clearId() => clearField(1);
}

class GetFieldsResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = new $pb.BuilderInfo('GetFieldsResponse', package: const $pb.PackageName('helloworld'))
    ..aOS(1, 'id')
    ..m<String, Field>(2, 'fields', 'GetFieldsResponse.FieldsEntry',$pb.PbFieldType.OS, $pb.PbFieldType.OM, Field.create, null, null , const $pb.PackageName('helloworld'))
    ..hasRequiredFields = false
  ;

  GetFieldsResponse() : super();
  GetFieldsResponse.fromBuffer(List<int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  GetFieldsResponse.fromJson(String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  GetFieldsResponse clone() => new GetFieldsResponse()..mergeFromMessage(this);
  GetFieldsResponse copyWith(void Function(GetFieldsResponse) updates) => super.copyWith((message) => updates(message as GetFieldsResponse));
  $pb.BuilderInfo get info_ => _i;
  static GetFieldsResponse create() => new GetFieldsResponse();
  GetFieldsResponse createEmptyInstance() => create();
  static $pb.PbList<GetFieldsResponse> createRepeated() => new $pb.PbList<GetFieldsResponse>();
  static GetFieldsResponse getDefault() => _defaultInstance ??= create()..freeze();
  static GetFieldsResponse _defaultInstance;
  static void $checkItem(GetFieldsResponse v) {
    if (v is! GetFieldsResponse) $pb.checkItemFailed(v, _i.qualifiedMessageName);
  }

  String get id => $_getS(0, '');
  set id(String v) { $_setString(0, v); }
  bool hasId() => $_has(0);
  void clearId() => clearField(1);

  Map<String, Field> get fields => $_getMap(1);
}

