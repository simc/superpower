part of superpower;

abstract class _$DelegatingIterable<E> extends DelegatingIterable<E> {
  /// Source of the wrapper.
  final Iterable<E> source;

  _$DelegatingIterable._(this.source) : super(source);

  int _allowNegativeIndex(int index) {
    if (index < 0)
      return index + length;
    else
      return index;
  }

  @override
  E elementAt(int index) {
    index = _allowNegativeIndex(index);
    return super.elementAt(index);
  }

  @override
  Iterator<E> get iterator => source.iterator;

  @override
  int get length => source.length;

  @override
  $List<R> cast<R>() => $List(super.cast());

  @override
  $Iterable<E> followedBy(Iterable<E> other) =>
      $Iterable(super.followedBy(other));

  @override
  $Iterable<T> map<T>(T f(E e)) => $Iterable(super.map(f));

  @override
  $Iterable<E> where(bool test(E element)) => $Iterable(super.where(test));

  @override
  $Iterable<T> whereType<T>() => $Iterable(super.whereType());

  @override
  $Iterable<T> expand<T>(Iterable<T> f(E element)) =>
      $Iterable(super.expand(f));

  @override
  $List<E> toList({bool growable: true}) => $List(super.toList());

  @override
  $Iterable<E> take(int count) => $Iterable(super.take(count));

  @override
  $Iterable<E> takeWhile(bool test(E value)) =>
      $Iterable(super.takeWhile(test));

  @override
  $Iterable<E> skip(int count) => $Iterable(super.skip(count));

  @override
  $Iterable<E> skipWhile(bool test(E value)) =>
      $Iterable(super.skipWhile(test));
}
