part of superpower;

var _binarySearch = binarySearch;
var _lowerBound = lowerBound;
var _insertionSort = insertionSort;
var _mergeSort = mergeSort;
var _groupBy = groupBy;

/// Creates a [$List] from given [iterable].
///
/// If [iterable] is omitted, an empty list is returned.
///
/// Iterables which are not of type [List] are converted to a list.
$List<E> $<E>([Iterable<E> iterable]) => $List(iterable);

/// Wrapper for [List].
class $List<E> extends _$DelegatingList<E> {
  $List._(Iterable<E> iterable) : super._(iterable) {}

  /// Creates a [$List] from given [iterable].
  ///
  /// If [iterable] is omitted, an empty list is returned.
  ///
  /// Iterables which are not of type [List] are converted to a list.
  factory $List([Iterable<E> iterable]) {
    if (iterable == null)
      return $List._(List());
    else if (iterable is List<E>)
      return $List._(iterable);
    else
      return $List._(iterable.toList());
  }

  /// Creates a list of the given [length].
  ///
  /// This constructor creates a growable list when [growable] is true or
  /// [length] is 0; otherwise, it returns a fixed-length list.
  factory $List.withLength(int length, {bool growable: false}) {
    if (growable == true || length == 0)
      return $List(List()..length = length);
    else
      return $List(List(length));
  }

  /// Creates a list of the given length, and initializes the value at each
  /// position with [fill].
  ///
  /// This constructor creates a growable list when [growable] is true;
  /// otherwise, it returns a fixed-length list.
  ///
  /// ```dart
  /// $List<int>.filled(3, 0); // [0, 0, 0]
  /// ```
  factory $List.filled(int length, E fill, {bool growable: false}) {
    return $List(List.filled(length, fill, growable: growable));
  }

  /// Generates a list of values.
  ///
  /// Creates a list with [length] positions and fills it with values created by
  /// calling [generator] for each index in the range `0` .. `length - 1`
  /// in increasing order.
  ///
  /// ```dart
  /// $List<int>.generate(3, (int index) => index * index); // [0, 1, 4]
  /// ```
  ///
  /// The created list is fixed-length unless [growable] is true.
  factory $List.generate(int length, E generator(int index),
      {bool growable: true}) {
    return $List(List.generate(length, generator, growable: growable));
  }

  /// Creates an unmodifiable list containing all [elements].
  ///
  /// The [Iterator] of [elements] provides the order of the elements.
  ///
  /// An unmodifiable list cannot have its length or elements changed.
  /// If the elements are themselves immutable, then the resulting list
  /// is also immutable.
  factory $List.unmodifiable(Iterable<E> elements) {
    return $List(List.unmodifiable(elements));
  }

  set lastIndex(int value) => length = value + 1;

  set second(E value) => this[1] = value;

  set third(E value) => this[2] = value;

  set fourth(E value) => this[3] = value;

  @override
  E elementAtOrElse(int index, E defaultValue(int index)) {
    index = _allowNegativeIndex(index);
    return index >= 0 && index <= lastIndex ? this[index] : defaultValue(index);
  }

  /// Returns a new list containing all elements except last [n] elements.
  $List<E> dropLast(int n) {
    if (n < 0)
      throw ArgumentError("Requested element count $n is less than zero.");
    if (n == 0) toList();

    var resultSize = length - n;
    if (resultSize <= 0) return $List();
    if (resultSize == 1) return $List([first]);
    return sublist(0, length - n);
  }

  /// Returns a new list containing all elements except last elements that satisfy
  /// the given [predicate].
  $List<E> dropLastWhile(bool predicate(E element)) {
    int endIndex;
    for (var i = lastIndex; i >= 0; i--) {
      if (!predicate(this[i])) {
        endIndex = i;
        break;
      }
    }
    if (endIndex == null) return $List();
    return sublist(0, endIndex + 1);
  }

  /// Returns a position of the [value] in this list, if it is there.
  ///
  /// If the list isn't sorted according to the [compare] function, the result
  /// is unpredictable.
  ///
  /// If [compare] is omitted, this defaults to calling [Comparable.compareTo] on
  /// the objects. If any object is not [Comparable], this throws a [CastError].
  ///
  /// Returns -1 if [value] is not in the list by default.
  int binarySearch(E value, {int compare(E a, E b)}) {
    return _binarySearch(this, value, compare: compare);
  }

  /// Returns the first position in this list that does not compare less than
  /// [value].
  ///
  /// If this list isn't sorted according to the [compare] function, the result
  /// is unpredictable.
  ///
  /// If [compare] is omitted, this defaults to calling [Comparable.compareTo] on
  /// the objects. If any object is not [Comparable], this throws a [CastError].
  ///
  /// Returns [length] if all the items in this list compare less than [value].
  int lowerBound(E value, {int compare(E a, E b)}) {
    return _lowerBound(this, value, compare: compare);
  }

  /// Sort this list between [start] (inclusive) and [end] (exclusive) using
  /// insertion sort.
  ///
  /// If [comparator] is omitted, this defaults to calling
  /// [Comparable.compareTo] on the objects. If any object is not [Comparable],
  /// this throws a [CastError].
  ///
  /// Insertion sort is a simple sorting algorithm. For `n` elements it does on
  /// the order of `n * log(n)` comparisons but up to `n` squared moves. The
  /// sorting is performed in-place, without using extra memory.
  ///
  /// For short lists the many moves have less impact than the simple algorithm,
  /// and it is often the favored sorting algorithm for short lists.
  ///
  /// This insertion sort is stable: Equal elements end up in the same order
  /// as they started in.
  void insertionSort({Comparator<E> comparator, int start: 0, int end}) {
    start = _allowNegativeIndex(start);
    end = _allowNegativeIndex(end);
    _insertionSort(this, compare: comparator, start: start, end: end);
  }

  /// Sorts this list between [start] (inclusive) and [end] (exclusive) using the
  /// merge sort algorithm.
  ///
  /// If [comparator] is omitted, this defaults to calling [Comparable.compareTo]
  /// on the objects. If any object is not [Comparable], this throws a
  /// [CastError].
  ///
  /// Merge-sorting works by splitting the job into two parts, sorting each
  /// recursively, and then merging the two sorted parts.
  ///
  /// This takes on the order of `n * log(n)` comparisons and moves to sort
  /// `n` elements, but requires extra space of about the same size as the list
  /// being sorted.
  ///
  /// This merge sort is stable: Equal elements end up in the same order
  /// as they started in.
  void mergeSort({int start: 0, int end, Comparator<E> comparator}) {
    start = _allowNegativeIndex(start);
    end = _allowNegativeIndex(end);
    _mergeSort(this, start: start, end: end, compare: comparator);
  }
}
