extension IterableExtensions<E> on Iterable<E> {
  Iterable<T> mapIndexed<T>(T Function(int index, E e) f) sync* {
    int index = 0;
    for (final element in this) {
      yield f(index++, element);
    }
  }
}