
extension ListExtensions<T> on List<T> {
  int get lastIndex => length - 1;

  int? indexWhereOrNull(bool Function(T element) test) {
    for (var i = 0; i < length; i++) {
      if (test(this[i])) return i;
    }
    return null;
  }
}

extension Unique<T, Id> on List<T> {
  List<T> unique(Id Function(T element)? id, {bool inplace = true}) {
    final ids = <dynamic>{};
    return (inplace ? this : List<T>.from(this))
      ..retainWhere((x) => ids.add(id != null ? id(x) : x as Id));
  }
}
