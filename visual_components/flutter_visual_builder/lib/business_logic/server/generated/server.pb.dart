///
//  Generated code. Do not modify.
//  source: server.proto
///
// ignore_for_file: non_constant_identifier_names,library_prefixes,unused_import

// ignore: UNUSED_SHOWN_NAME
import 'dart:core' show int, bool, double, String, List, Map, override;

import 'package:protobuf/protobuf.dart' as $pb;

class Empty extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = new $pb.BuilderInfo('Empty', package: const $pb.PackageName('helloworld'))
    ..hasRequiredFields = false
  ;

  Empty() : super();
  Empty.fromBuffer(List<int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Empty.fromJson(String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Empty clone() => new Empty()..mergeFromMessage(this);
  Empty copyWith(void Function(Empty) updates) => super.copyWith((message) => updates(message as Empty));
  $pb.BuilderInfo get info_ => _i;
  static Empty create() => new Empty();
  Empty createEmptyInstance() => create();
  static $pb.PbList<Empty> createRepeated() => new $pb.PbList<Empty>();
  static Empty getDefault() => _defaultInstance ??= create()..freeze();
  static Empty _defaultInstance;
  static void $checkItem(Empty v) {
    if (v is! Empty) $pb.checkItemFailed(v, _i.qualifiedMessageName);
  }
}

class SourceCode extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = new $pb.BuilderInfo('SourceCode', package: const $pb.PackageName('helloworld'))
    ..aOS(1, 'sourceCode')
    ..hasRequiredFields = false
  ;

  SourceCode() : super();
  SourceCode.fromBuffer(List<int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  SourceCode.fromJson(String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  SourceCode clone() => new SourceCode()..mergeFromMessage(this);
  SourceCode copyWith(void Function(SourceCode) updates) => super.copyWith((message) => updates(message as SourceCode));
  $pb.BuilderInfo get info_ => _i;
  static SourceCode create() => new SourceCode();
  SourceCode createEmptyInstance() => create();
  static $pb.PbList<SourceCode> createRepeated() => new $pb.PbList<SourceCode>();
  static SourceCode getDefault() => _defaultInstance ??= create()..freeze();
  static SourceCode _defaultInstance;
  static void $checkItem(SourceCode v) {
    if (v is! SourceCode) $pb.checkItemFailed(v, _i.qualifiedMessageName);
  }

  String get sourceCode => $_getS(0, '');
  set sourceCode(String v) { $_setString(0, v); }
  bool hasSourceCode() => $_has(0);
  void clearSourceCode() => clearField(1);
}

class InitSourceCodeStream extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = new $pb.BuilderInfo('InitSourceCodeStream', package: const $pb.PackageName('helloworld'))
    ..hasRequiredFields = false
  ;

  InitSourceCodeStream() : super();
  InitSourceCodeStream.fromBuffer(List<int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  InitSourceCodeStream.fromJson(String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  InitSourceCodeStream clone() => new InitSourceCodeStream()..mergeFromMessage(this);
  InitSourceCodeStream copyWith(void Function(InitSourceCodeStream) updates) => super.copyWith((message) => updates(message as InitSourceCodeStream));
  $pb.BuilderInfo get info_ => _i;
  static InitSourceCodeStream create() => new InitSourceCodeStream();
  InitSourceCodeStream createEmptyInstance() => create();
  static $pb.PbList<InitSourceCodeStream> createRepeated() => new $pb.PbList<InitSourceCodeStream>();
  static InitSourceCodeStream getDefault() => _defaultInstance ??= create()..freeze();
  static InitSourceCodeStream _defaultInstance;
  static void $checkItem(InitSourceCodeStream v) {
    if (v is! InitSourceCodeStream) $pb.checkItemFailed(v, _i.qualifiedMessageName);
  }
}

class FieldUpdate extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = new $pb.BuilderInfo('FieldUpdate', package: const $pb.PackageName('helloworld'))
    ..aOS(1, 'id')
    ..aOS(2, 'propertyName')
    ..aOS(3, 'property')
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

  String get id => $_getS(0, '');
  set id(String v) { $_setString(0, v); }
  bool hasId() => $_has(0);
  void clearId() => clearField(1);

  String get propertyName => $_getS(1, '');
  set propertyName(String v) { $_setString(1, v); }
  bool hasPropertyName() => $_has(1);
  void clearPropertyName() => clearField(2);

  String get property => $_getS(2, '');
  set property(String v) { $_setString(2, v); }
  bool hasProperty() => $_has(2);
  void clearProperty() => clearField(3);
}

class Field extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = new $pb.BuilderInfo('Field', package: const $pb.PackageName('helloworld'))
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

class SelectStream extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = new $pb.BuilderInfo('SelectStream', package: const $pb.PackageName('helloworld'))
    ..hasRequiredFields = false
  ;

  SelectStream() : super();
  SelectStream.fromBuffer(List<int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  SelectStream.fromJson(String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  SelectStream clone() => new SelectStream()..mergeFromMessage(this);
  SelectStream copyWith(void Function(SelectStream) updates) => super.copyWith((message) => updates(message as SelectStream));
  $pb.BuilderInfo get info_ => _i;
  static SelectStream create() => new SelectStream();
  SelectStream createEmptyInstance() => create();
  static $pb.PbList<SelectStream> createRepeated() => new $pb.PbList<SelectStream>();
  static SelectStream getDefault() => _defaultInstance ??= create()..freeze();
  static SelectStream _defaultInstance;
  static void $checkItem(SelectStream v) {
    if (v is! SelectStream) $pb.checkItemFailed(v, _i.qualifiedMessageName);
  }
}

class RemovedWidget extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = new $pb.BuilderInfo('RemovedWidget', package: const $pb.PackageName('helloworld'))
    ..aOS(1, 'id')
    ..hasRequiredFields = false
  ;

  RemovedWidget() : super();
  RemovedWidget.fromBuffer(List<int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  RemovedWidget.fromJson(String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  RemovedWidget clone() => new RemovedWidget()..mergeFromMessage(this);
  RemovedWidget copyWith(void Function(RemovedWidget) updates) => super.copyWith((message) => updates(message as RemovedWidget));
  $pb.BuilderInfo get info_ => _i;
  static RemovedWidget create() => new RemovedWidget();
  RemovedWidget createEmptyInstance() => create();
  static $pb.PbList<RemovedWidget> createRepeated() => new $pb.PbList<RemovedWidget>();
  static RemovedWidget getDefault() => _defaultInstance ??= create()..freeze();
  static RemovedWidget _defaultInstance;
  static void $checkItem(RemovedWidget v) {
    if (v is! RemovedWidget) $pb.checkItemFailed(v, _i.qualifiedMessageName);
  }

  String get id => $_getS(0, '');
  set id(String v) { $_setString(0, v); }
  bool hasId() => $_has(0);
  void clearId() => clearField(1);
}

class SelectedWidgetWithProperties extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = new $pb.BuilderInfo('SelectedWidgetWithProperties', package: const $pb.PackageName('helloworld'))
    ..aOS(1, 'id')
    ..aOS(2, 'type')
    ..m<String, String>(3, 'properties', 'SelectedWidgetWithProperties.PropertiesEntry',$pb.PbFieldType.OS, $pb.PbFieldType.OS, null, null, null , const $pb.PackageName('helloworld'))
    ..hasRequiredFields = false
  ;

  SelectedWidgetWithProperties() : super();
  SelectedWidgetWithProperties.fromBuffer(List<int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  SelectedWidgetWithProperties.fromJson(String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  SelectedWidgetWithProperties clone() => new SelectedWidgetWithProperties()..mergeFromMessage(this);
  SelectedWidgetWithProperties copyWith(void Function(SelectedWidgetWithProperties) updates) => super.copyWith((message) => updates(message as SelectedWidgetWithProperties));
  $pb.BuilderInfo get info_ => _i;
  static SelectedWidgetWithProperties create() => new SelectedWidgetWithProperties();
  SelectedWidgetWithProperties createEmptyInstance() => create();
  static $pb.PbList<SelectedWidgetWithProperties> createRepeated() => new $pb.PbList<SelectedWidgetWithProperties>();
  static SelectedWidgetWithProperties getDefault() => _defaultInstance ??= create()..freeze();
  static SelectedWidgetWithProperties _defaultInstance;
  static void $checkItem(SelectedWidgetWithProperties v) {
    if (v is! SelectedWidgetWithProperties) $pb.checkItemFailed(v, _i.qualifiedMessageName);
  }

  String get id => $_getS(0, '');
  set id(String v) { $_setString(0, v); }
  bool hasId() => $_has(0);
  void clearId() => clearField(1);

  String get type => $_getS(1, '');
  set type(String v) { $_setString(1, v); }
  bool hasType() => $_has(1);
  void clearType() => clearField(2);

  Map<String, String> get properties => $_getMap(2);
}

