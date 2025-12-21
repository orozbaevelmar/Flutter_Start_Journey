class Wrapped<T> {
  final T? value;

  const Wrapped.value(this.value);

  const Wrapped.nulled() : value = null;
}
