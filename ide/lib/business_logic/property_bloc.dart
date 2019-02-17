import 'package:flutter_visual_builder/business_logic/server/generated/server.pb.dart';
import 'package:ide/business_logic/client/client.dart';
import 'package:rxdart/rxdart.dart';

class PropertyBloc {

  // TODO implement receiving widget removed events
  PropertyBloc._({this.editor, this.removedIds});

  factory PropertyBloc(VisualClient visualClient) {

    PublishSubject<String> removedIds = PublishSubject();

    Observable<SelectedWidgetWithProperties> widgetStream = Observable(visualClient.serverClient.streamSelected(SelectStream())
        .asBroadcastStream());

    return PropertyBloc._(
      editor: widgetStream,
      removedIds: removedIds,
    );
  }

  final Observable<SelectedWidgetWithProperties> editor;

  final Sink<String> removedIds;


}