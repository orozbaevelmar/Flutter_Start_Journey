extension IterableExtensions<T> on Iterable<T> {
  Iterable<R> mapIndexed<R>(R Function(int index, T element) f) {
    int index = 0;
    return map((element) => f(index++, element));
  }
}
 // I can use this extension in DropDownBuider...