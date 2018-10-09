part of superpower;

/// Should only be used throught [$Iterable.sortedBy].
///
/// **Note:** The actual sorting is performed when an element is accessed for
/// the first time.
class $OrderedList<E> extends _$LazyList<E> {
  $OrderedList<E> _parent;
  Comparator<E> _comparator;

  $OrderedList._(
    Iterable<E> source,
    this._comparator,
    this._parent,
  ) : super._(source);

  $OrderedList._withSelector(
    Iterable<E> source,
    Comparable selector(E element),
    int order,
    this._parent,
  ) : super._(source) {
    _comparator = (E a, E b) {
      return order * selector(a).compareTo(selector(b));
    };
  }

  /// Returns a new list with all elements sorted according to previously
  /// defined order and natural sort order of the values returned by specified
  /// [selector] function.
  ///
  /// **Note:** The actual sorting is performed when an element is accessed for
  /// the first time.
  $OrderedList<E> thenBy(Comparable selector(E element)) {
    return $OrderedList<E>._withSelector(source, selector, 1, this);
  }

  /// Returns a new list with all elements sorted according to previously
  /// defined order and descending natural sort order of the values returned by
  /// specified [selector] function.
  ///
  /// **Note:** The actual sorting is performed when an element is accessed for
  /// the first time.
  $OrderedList<E> thenByDescending(Comparable selector(E element)) {
    return $OrderedList<E>._withSelector(source, selector, -1, this);
  }

  /// Returns a new list with all elements sorted according to previously
  /// defined order and specified [comparator].
  ///
  /// **Note:** The actual sorting is performed when an element is accessed for
  /// the first time.
  $OrderedList<E> thenWith(Comparator<E> comparator) {
    return $OrderedList<E>._(source, comparator, this);
  }

  int _compare(E element1, E element2) {
    int compare = 0;
    if (_parent != null) {
      compare = _parent._compare(element1, element2);
    }
    if (compare == 0)
      return _comparator(element1, element2);
    else
      return compare;
  }

  @override
  List<E> _createList() {
    var list = toList();
    list.sort(_compare);
    return list;
  }
}
