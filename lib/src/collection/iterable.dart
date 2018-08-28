part of superpower;

/// Wrapper for [$Iterable].
class $Iterable<E> extends _$DelegatingIterable<E> {
  $Iterable._(Iterable<E> source) : super._(source);

  /// Creates an [$Iterable] from an existing iterable.
  ///
  /// If the iterable is of type [List], a [$List] is returned for better
  /// performance.
  factory $Iterable(Iterable<E> iterable) {
    if (iterable is List)
      return $List._(iterable);
    else
      return $Iterable<E>._(iterable);
  }

  /// Creates an [$Iterable] which generates its elements dynamically.
  ///
  /// The generated iterable has [count] elements,
  /// and the element at index `n` is computed by calling `generator(n)`.
  /// Values are not cached, so each iteration computes the values again.
  ///
  /// If [generator] is omitted, it defaults to an identity function
  /// on integers `(int x) => x`, so it may only be omitted if the type
  /// parameter allows integer values. That is, if [E] is one of
  /// `int`, `num`, `Object` or `dynamic`.
  factory $Iterable.generate(int count, [E generator(int index)]) {
    return $Iterable(Iterable.generate(count, generator));
  }

  /// Creates an empty iterable.
  ///
  /// The empty iterable has no elements, and iterating it always stops
  /// immediately.
  factory $Iterable.empty() => $Iterable(Iterable.empty());

  // Access elements

  /// Index of the first element or -1 if the collection is empty.
  int get firstIndex => isNotEmpty ? 0 : -1;

  /// Index of the last element or -1 if the collection is empty.
  int get lastIndex => length - 1;

  /// Second element.
  E get second => elementAt(1);

  /// Third element.
  E get third => elementAt(2);

  /// Fourth element.
  E get fourth => elementAt(3);

  /// Returns an element at the given [index] or `null` if the [index] is out of
  /// bounds of this collection.
  E elementAtOrNull(int index) {
    return elementAtOrElse(index, (_) => null);
  }

  /// Returns an element at the given [index] or the result of calling the
  /// [defaultValue] function if the [index] is out of bounds of this
  /// collection.
  E elementAtOrElse(int index, E defaultValue(int index)) {
    index = _allowNegativeIndex(index);
    if (index < 0) return defaultValue(index);
    var it = iterator;
    var count = 0;
    while (it.moveNext()) {
      if (index == count++) return it.current;
    }
    return defaultValue(index);
  }

  /// First element or `null` if the collection is empty.
  E get firstOrNull => elementAtOrNull(0);

  /// First element or `defaultValue` if the collection is empty.
  E firstOrElse(E defaultValue) => firstOrNull ?? defaultValue;

  /// Returns the first element matching the given [predicate], or `null` if no
  /// such element was found.
  E firstOrNullWhere(bool predicate(E element)) {
    return firstWhere(predicate, orElse: () => null);
  }

  /// Last element or `null` if the collection is empty.
  E get lastOrNull => isNotEmpty ? last : null;

  /// Last element or `defaultValue` if the collection is empty.
  E lastOrElse(E defaultValue) => lastOrNull ?? defaultValue;

  /// Returns the last element matching the given [predicate], or `null` if no
  /// such element was found.
  E lastOrNullWhere(bool predicate(E element)) {
    return lastWhere(predicate, orElse: () => null);
  }

  /// Returns an original collection containing all the non-null elements, throwing an IllegalArgumentException if there are any null elements.
  void requireNoNulls() {
    if (any((element) => element == null)) {
      throw AssertionError("element is null");
    }
  }

  /// Returns true if no entries match the given [predicate] or if the
  /// collection is empty.
  bool none(bool predicate(E element)) => !any(predicate);

  /// Returns a new list containing all elements except first [n] elements.
  $List<E> drop(int n) {
    if (n < 0)
      throw ArgumentError("Requested element count $n is less than zero.");
    if (n == 0) return toList();

    var resultList = $List<E>();
    var count = 0;
    for (var item in this) {
      if (count++ >= n) {
        resultList.add(item);
      }
    }
    return resultList;
  }

  /// Returns a new list containing all elements except first elements that satisfy
  /// the given [predicate].
  $List<E> dropWhile(bool predicate(E element)) {
    var yielding = false;
    var list = $List<E>();
    for (var item in this) {
      if (yielding)
        list.add(item);
      else if (!predicate(item)) {
        list.add(item);
        yielding = true;
      }
    }
    return list;
  }

  /// Returns a new list containing elements at indices between [start]
  /// (inclusive) and [end] (inclusive).
  ///
  /// If given [ignoreOutOfRange] is false (default), an exception is thrown if
  /// [start] or [end] are out of bounds. Otherwise, there is no exception and
  /// the existing elements are being returned.
  ///
  /// If [end] is omitted, it is being set to [lastIndex].
  $List<E> slice(int start, [int end, bool ignoreOutOfRange = false]) {
    var list = this is $List ? this as $List<E> : toList();

    if (list.isEmpty) {
      if (ignoreOutOfRange)
        return $List();
      else
        throw RangeError("List is empty.");
    }

    if (start < 0) {
      start = start + list.length;
    }
    if (end == null) {
      end = list.lastIndex;
    }
    if (end < 0) {
      end = end + list.length;
    }
    if (end < start) {
      throw RangeError("end must be behind start.");
    }

    if (start < 0) {
      if (ignoreOutOfRange)
        start = 0;
      else
        throw RangeError("start out of range.");
    }

    if (end > lastIndex) {
      if (ignoreOutOfRange)
        end = lastIndex;
      else
        throw RangeError("end out of range.");
    }

    return list.sublist(start, end + 1);
  }

  /// Performs the given [action] on each element, providing sequential index
  /// with the element.
  void forEachIndexed(void action(E element, int index)) {
    var index = 0;
    for (E element in this) action(element, index++);
  }

  /// Returns a new lazy [$Iterable] with all elements that satisfy the
  /// given [predicate].
  $Iterable<E> whereIndexed(bool predicate(E element, int index)) {
    var index = 0;
    return $Iterable(where((element) => predicate(element, index++)));
  }

  /// Returns a new lazy [$Iterable] with all elements which are not null.
  $Iterable<E> get whereNotNull =>
      $Iterable(where((element) => element != null));

  /// Returns true if this collection is structurally equal to the [other]
  /// collection.
  ///
  /// I.e. contain the same number of the same elements in the same order.
  ///
  /// If [checkEqual] is provided, it is used to check if two elements are the
  /// same.
  bool contentEquals(Iterable<E> other, [bool checkEqual(E a, E b)]) {
    var it1 = iterator;
    var it2 = other.iterator;
    if (checkEqual != null) {
      while (it1.moveNext()) {
        if (!it2.moveNext()) return false;
        if (!checkEqual(it1.current, it2.current)) return false;
      }
    } else {
      while (it1.moveNext()) {
        if (!it2.moveNext()) return false;
        if (it1.current != it2.current) return false;
      }
    }
    return !it2.moveNext();
  }

  //Soting operations

  /// Returns a new list with all elements sorted according to natural sort
  /// order.
  $List<E> sorted() {
    var list = toList();
    list.sort();
    return list;
  }

  /// Returns a new list with all elements sorted according to descending
  /// natural sort order.
  $List<E> sortedDescending() {
    var list = toList();
    var comparableList = list as List<Comparable>;
    comparableList.sort((a, b) => -a.compareTo(b));
    return list;
  }

  /// Returns a new list with all elements sorted according to natural sort
  /// order of the values returned by specified [selector] function.
  ///
  /// To sort by more than one property, `thenBy()` or `thenByDescending()` can
  /// be called afterwards.
  ///
  /// **Note:** The actual sorting is performed when an element is accessed for
  /// the first time.
  $OrderedList<E> sortedBy(Comparable selector(E element)) {
    return $OrderedList<E>._withSelector(this, selector, 1, null);
  }

  /// Returns a new list with all elements sorted according to descending
  /// natural sort order of the values returned by specified [selector] function.
  ///
  /// To sort by more than one property, `thenBy()` or `thenByDescending` can
  /// be called afterwards.
  ///
  /// **Note:** The actual sorting is performed when an element is accessed for
  /// the first time.
  $OrderedList<E> sortedByDescending(Comparable selector(E element)) {
    return $OrderedList<E>._withSelector(this, selector, -1, null);
  }

  /// Returns a new list with all elements sorted according to specified
  /// [comparator].
  ///
  /// To sort by more than one property, `thenBy()` or `thenByDescending` can
  /// be called afterwards.
  ///
  /// **Note:** The actual sorting is performed when an element is accessed for
  /// the first time.
  $OrderedList<E> sortedWith(Comparator<E> comparator) {
    return $OrderedList<E>._(this, comparator, null);
  }

  //Math operations

  /// Returns the sum of all elements in the collection.
  ///
  /// All elements have to be of type [num] or `null`. `null` elements are not
  /// counted.
  double sum() {
    var sum = 0.0;
    for (var current in this) {
      sum += (current as num) ?? 0;
    }
    return sum;
  }

  /// Returns the sum of all values produced by [selector] function applied to
  /// each element in the collection.
  ///
  /// `null` values are not counted.
  double sumBy(num selector(E element)) {
    var sum = 0.0;
    for (var current in this) {
      sum += selector(current) ?? 0;
    }
    return sum;
  }

  /// Returns an average value of elements in the collection.
  ///
  /// All elements must be of type [Comparable].
  /// `null` elements are counted as 0. Empty collections return null.
  double average() {
    var count = 0;
    num sum = 0;
    for (var current in this as Iterable<num>) {
      if (current != null) {
        sum += current;
      }
      count++;
    }

    if (count == 0)
      return null;
    else
      return sum / count;
  }

  /// Returns an average values returned by [selector] for all elements in
  /// the collection.
  ///
  /// `null` values are counted as 0. Empty collections return null.
  double averageBy(num selector(E element)) {
    var count = 0;
    num sum = 0;

    for (var current in this) {
      var value = selector(current);
      if (value != null) {
        sum += value;
      }
      count++;
    }

    if (count == 0)
      return null;
    else
      return sum / count;
  }

  /// Returns the smallest element or `null` if there are no elements.
  ///
  /// All elements must be of type [Comparable].
  E min() {
    return _minMax(-1);
  }

  /// Returns the first element yielding the smallest value of the given
  /// [selector] or `null` if there are no elements.
  E minBy(Comparable selector(E element)) {
    return _minMaxBy(-1, selector);
  }

  /// Returns the first element having the smallest value according to the
  /// provided [comparator] or `null` if there are no elements.
  E minWith(Comparator<E> comparator) {
    return _minMaxWith(-1, comparator);
  }

  /// Returns the largest element or `null` if there are no elements.
  ///
  /// All elements must be of type [Comparable].
  E max() {
    return _minMax(1);
  }

  /// Returns the first element yielding the largest value of the given
  /// [selector] or `null` if there are no elements.
  E maxBy(Comparable selector(E element)) {
    return _minMaxBy(1, selector);
  }

  /// Returns the first element having the largest value according to the
  /// provided [comparator] or `null` if there are no elements.
  E maxWith(Comparator<E> comparator) {
    return _minMaxWith(1, comparator);
  }

  E _minMax(int order) {
    var it = iterator as Iterator<Comparable>;
    it.moveNext();
    Comparable currentMin = it.current;

    while (it.moveNext()) {
      if (it.current.compareTo(currentMin) == order) {
        currentMin = it.current;
      }
    }

    return currentMin as E;
  }

  E _minMaxBy(int order, Comparable selector(E element)) {
    var it = iterator;
    it.moveNext();

    E currentMin = it.current;
    Comparable currentMinValue = selector(it.current);
    while (it.moveNext()) {
      var comp = selector(it.current);
      if (comp.compareTo(currentMinValue) == order) {
        currentMin = it.current;
        currentMinValue = comp;
      }
    }

    return currentMin;
  }

  E _minMaxWith(int order, Comparator<E> comparator) {
    var it = iterator;
    it.moveNext();
    E currentMin = it.current;

    while (it.moveNext()) {
      if (comparator(it.current, currentMin) == order) {
        currentMin = it.current;
      }
    }

    return currentMin;
  }

  /// Returns the number of elements matching the given [predicate].
  ///
  /// If no [predicate] is given, this equals [length].
  int count([bool predicate(E element)]) {
    var count = 0;
    if (predicate == null) {
      return length;
    } else {
      for (var current in this) {
        if (predicate(current)) {
          count++;
        }
      }
    }

    return count;
  }

  //Transformations

  /// Returns a new lazy [$Iterable] with elements in reversed order.
  $Iterable<E> reverse() {
    Iterable<E> generator() sync* {
      List<E> list;
      if (this is List<E>) {
        list = this as List<E>;
      } else {
        list = toList();
      }

      var length = list.length;
      for (var i = length - 1; i >= 0; i--) {
        yield list[i];
      }
    }

    return $Iterable(generator());
  }

  /// Returns a new lazy [$Iterable] containing only distinct elements from the
  /// collection.
  ///
  /// The elements in the resulting list are in the same order as they were in
  /// the source collection.
  $Iterable<E> distinct() {
    Iterable<E> generator() sync* {
      var existing = HashSet<E>();
      for (var current in this) {
        if (existing.add(current)) {
          yield current;
        }
      }
    }

    return $Iterable(generator());
  }

  /// Returns a new lazy [$Iterable] containing only elements from the collection
  /// having distinct keys returned by the given [selector] function.
  ///
  /// The elements in the resulting list are in the same order as they were in
  /// the source collection.
  $Iterable<E> distinctBy<R>(R selector(E element)) {
    Iterable<E> generator() sync* {
      var existing = HashSet<R>();
      for (var current in this) {
        if (existing.add(selector(current))) {
          yield current;
        }
      }
    }

    return $Iterable(generator());
  }

  /// Splits this collection into a new lazy [$Iterable] of lists each not
  /// exceeding the given [size].
  ///
  /// The last list in the resulting list may have less elements than the given
  /// [size].
  ///
  /// [size] must be positive and can be greater than the number of elements in
  /// this collection.
  $Iterable<$List<E>> chunked(int size) {
    if (size < 1) {
      throw ArgumentError("Requested chunk size $size is less than one.");
    }

    Iterable<$List<E>> generator() sync* {
      var currentChunk = $List<E>();
      for (var current in this) {
        currentChunk.add(current);
        if (currentChunk.length >= size) {
          yield currentChunk;
          currentChunk = $List<E>();
        }
      }
      if (currentChunk.isNotEmpty) {
        yield currentChunk;
      }
    }

    return $Iterable(generator());
  }

  /// Returns a new lazy [$Iterable] of all elements yielded from results of
  /// [transform] function being invoked on each element of this collection.
  $Iterable<R> flatMap<R>(Iterable<R> transform(E element)) {
    Iterable<R> generator() sync* {
      for (var current in this) {
        yield* transform(current);
      }
    }

    return $Iterable(generator());
  }

  /// Returns a new lazy [$Iterable] of all elements from all collections in this
  /// collection.
  ///
  /// ```dart
  /// var nestedList = $List([[1, 2, 3], [4, 5, 6]]);
  /// var flattened = nestedList.flatten(); // [1, 2, 3, 4, 5, 6]
  /// ```
  $Iterable<dynamic> flatten() {
    Iterable<dynamic> generator() sync* {
      for (var current in this) {
        yield* (current as Iterable);
      }
    }

    return $Iterable<dynamic>(generator());
  }

  /// Returns a new lazy [$Iterable] which iterates over this collection forever.
  ///
  /// When it reaches the end, it jumps back to the beginning. Returns `null`
  /// forever if the collection is empty.
  $Iterable<E> cycle() {
    Iterable<E> generator() sync* {
      var it = iterator;
      if (!it.moveNext()) {
        while (true) {
          yield null;
        }
      } else {
        yield it.current;
        while (true) {
          while (it.moveNext()) {
            yield it.current;
          }
          it = iterator;
        }
      }
    }

    return $Iterable(generator());
  }

  //Operations with other iterables

  /// Returns a new lazy [$Iterable] containing all elements that are contained
  /// by both this collection and the [other] collection.
  ///
  /// The returned collection preserves the element iteration order of the
  /// this collection.
  $Iterable<E> intersect(Iterable<E> other) {
    Iterable<E> generator() sync* {
      var second = HashSet<E>.from(other);
      var output = HashSet<E>();
      for (var current in this) {
        if (second.contains(current)) {
          if (output.add(current)) {
            yield current;
          }
        }
      }
    }

    return $Iterable(generator());
  }

  /// Returns a new lazy [$Iterable] containing all elements of this collection
  /// except the elements contained in the given [elements] collection.
  $Iterable<E> except(Iterable<E> elements) {
    Iterable<E> generator() sync* {
      for (var current in this) {
        if (!elements.contains(current)) yield current;
      }
    }

    return $Iterable(generator());
  }

  /// Returns a new list containing all elements of this collection except the
  /// elements contained in the given [elements] collection.
  $List<E> operator -(Iterable<E> elements) => except(elements).toList();

  /// Returns a new lazy [$Iterable] containing all elements of this collection
  /// except the given [element].
  $Iterable<E> exceptElement(E element) {
    Iterable<E> generator() sync* {
      for (var current in this) {
        if (element != current) yield current;
      }
    }

    return $Iterable(generator());
  }

  /// Returns a new lazy [$Iterable] containing all elements of this collection
  /// and then all elements of the given [elements] collection.
  $Iterable<E> prepend(Iterable<E> elements) {
    Iterable<E> generator() sync* {
      yield* elements;
      yield* this;
    }

    return $Iterable(generator());
  }

  /// Returns a new lazy [$Iterable] containing all elements of this collection
  /// and then the given [element].
  $Iterable<E> prependElement(E element) {
    Iterable<E> generator() sync* {
      yield element;
      yield* this;
    }

    return $Iterable(generator());
  }

  /// Returns a new lazy [$Iterable] containing all elements of the given
  /// [elements] collection and then all elements of this collection.
  $Iterable<E> append(Iterable<E> elements) {
    Iterable<E> generator() sync* {
      yield* this;
      yield* elements;
    }

    return $Iterable(generator());
  }

  /// Returns a new list containing all elements of the given [elements]
  /// collection and then all elements of this collection.
  $List<E> operator +(Iterable<E> elements) => append(elements).toList();

  /// Returns a new lazy [$Iterable] containing the given [element] and then all
  /// elements of this collection.
  $Iterable<E> appendElement(E element) {
    Iterable<E> generator() sync* {
      yield* this;
      yield element;
    }

    return $Iterable(generator());
  }

  /// Returns a new lazy [$Iterable] containing all distinct elements from
  /// both collections.
  ///
  /// The returned set preserves the element iteration order of this collection.
  /// Those elements of the [other] collection that are unique are iterated in
  /// the end in the order of the [other] collection.
  $Iterable<E> union(Iterable<E> other) {
    Iterable<E> generator() sync* {
      var existing = HashSet<E>();
      for (var element in this) {
        if (existing.add(element)) yield element;
      }

      for (var element in other) {
        if (existing.add(element)) yield element;
      }
    }

    return $Iterable(generator());
  }

  /// Returns a new lazy [$Iterable] of values built from the elements of this
  /// collection and the [other] collection with the same index.
  ///
  /// Using the provided [transform] function applied to each pair of elements.
  /// The returned list has length of the shortest collection.
  $Iterable<R> zip<R>(Iterable<E> other, R transform(E a, E b)) {
    Iterable<R> generator() sync* {
      var it1 = iterator;
      var it2 = other.iterator;
      while (it1.moveNext() && it2.moveNext()) {
        yield transform(it1.current, it2.current);
      }
    }

    return $Iterable(generator());
  }

  ///Tranformations to other structures

  /// Returns a new lazy [$Iterable] with all elements of this collection.
  $Iterable<E> toIterable() {
    Iterable<E> generator() sync* {
      yield* this;
    }

    return $Iterable(generator());
  }

  /// Returns a new lazy list. It is lazily created when an element is accessed
  /// for the first time.
  ///
  /// **Note:** This is only useful for `$Iterable`s. With `$Lists`, this
  /// behaves like `toList()`.
  _$LazyList<E> toLazyList() => _$LazyList._(this);

  /// Returns a new [Set] with all distinct elements of this collection.
  Set<E> toSet() => Set.from(this);

  /// Returns a new [HashSet] with all distinct elements of this collection.
  HashSet<E> toHashSet() => HashSet.from(this);

  /// Returns an unmodifiable List view of this collection.
  List<E> toUnmodifiable() => UnmodifiableListView(this);

  /// Returns a Map containing key-value pairs provided by [transform] function
  /// applied to elements of this collection.
  ///
  /// If any of two pairs would have the same key the last one gets added to the
  /// map.
  Map<K, V> associate<K, V>(MapEntry<K, V> transform(E element)) {
    var map = Map<K, V>();
    for (var current in this) {
      var entry = transform(current);
      map[entry.key] = entry.value;
    }
    return map;
  }

  /// Returns a Map containing the elements from the collection indexed by
  /// the key returned from [keySelector] function applied to each element.
  ///
  /// If any two elements would have the same key returned by [keySelector] the
  /// last one gets added to the map.
  Map<K, E> associateBy<K>(K keySelector(E element)) {
    var map = Map<K, E>();
    for (var current in this) {
      map[keySelector(current)] = current;
    }
    return map;
  }

  /// Returns a Map containing the values returned from [valueSelector] function
  /// applied to each element indexed by the elements from the collection.
  ///
  /// If any of elements (-> keys) would be the same the last one gets added
  /// to the map.
  Map<E, V> associateWith<V>(V valueSelector(E element)) {
    var map = Map<E, V>();
    for (var current in this) {
      map[current] = valueSelector(current);
    }
    return map;
  }

  /// Groups elements of the original collection by the key returned by the
  /// given [keySelector] function applied to each element and returns a map.
  ///
  /// Each group key is associated with a list of corresponding elements.
  ///
  /// The returned map preserves the entry iteration order of the keys produced
  /// from the original collection.
  Map<K, List<E>> groupBy<K>(K keySelector(E element)) {
    return _groupBy(this, keySelector);
  }

  /// Splits the collection into two lists according to [predicate].
  ///
  /// The first list contains elements for which [predicate] yielded true,
  /// while the second list contains elements for which [predicate] yielded false.
  $List<$List<E>> partition(bool predicate(E element)) {
    var t = $List<E>();
    var f = $List<E>();
    var it = iterator;
    while (it.moveNext()) {
      if (predicate(it.current))
        t.add(it.current);
      else
        f.add(it.current);
    }
    return $List([t, f]);
  }
}
