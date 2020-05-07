
/// This should be renamed, not a generic class anymore but specifically used
/// to transmit tree data for flat data.
class IndexedObject<T> {

  IndexedObject({this.index, this.object, this.treePart});

  final int index;
  final T object;
  final List<int> treePart;

}


