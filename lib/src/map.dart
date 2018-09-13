part of superpower;

$Map<K, V> $map<K, V>([Map<K, V> map]) => $Map(map);

class $Map<K, V> extends _$DelegatingMap<K, V> {
  $Map._(Map<K, V> source) : super._(source);

  factory $Map([Map<K, V> source]) {
    return $Map._(source ?? Map<K, V>());
  }

  V get(K key) => this[key];

  V getOrDefault(K key, V defaultValue) => this[key] ?? defaultValue;

  /// Returns true if no entries match the given [predicate] or if the
  /// collection is empty.
  bool any(bool predicate(K key, V value)) {
    for (var entry in entries) {
      if (predicate(entry.key, entry.value)) {
        return true;
      }
    }
    return false;
  }

  /// Returns true if no entries match the given [predicate] or if the
  /// collection is empty.
  bool all(bool predicate(K key, V value)) {
    for (var entry in entries) {
      if (!predicate(entry.key, entry.value)) {
        return false;
      }
    }
    return true;
  }

  /// Returns true if no entries match the given [predicate] or if the
  /// collection is empty.
  bool none(bool predicate(K key, V value)) => !any(predicate);

  /// Performs the given [action] on each element, providing sequential index
  /// with the element.
  void forEachIndexed(void action(K key, V value, int index)) {
    var index = 0;
    for (var entry in this.entries) {
      action(entry.key, entry.value, index++);
    }
  }

  /// Returns true if this collection is structurally equal to the [other]
  /// collection.
  ///
  /// I.e. contain the same number of the same elements in the same order.
  ///
  /// If [checkEqual] is provided, it is used to check if two elements are the
  /// same.
  bool contentEquals(Map<K, V> other,
      [bool checkEqual(MapEntry<K, V> a, MapEntry<K, V> b)]) {
    return entries.contentEquals(other.entries);
  }

  /// Creates a string from all the elements separated using [separator] and
  /// using the given [prefix] and [postfix] if supplied.
  ///
  /// If the collection could be huge, you can specify a non-negative value of
  /// [limit], in which case only the first [limit] elements will be appended,
  /// followed by the [truncated] string (which defaults to `"..."`).
  String joinToString({
    String separator = ", ",
    String transform(K key, V value),
    String prefix = "",
    String postfix = "",
    int limit,
    String truncated = "...",
  }) {
    var mapT = (MapEntry<K, V> entry) => transform(entry.key, entry.value);
    return entries.joinToString(
      separator: separator,
      transform: transform == null ? mapT : null,
      prefix: prefix,
      postfix: postfix,
      limit: limit,
      truncated: truncated,
    );
  }

  /// Returns the sum of all values produced by [selector] function applied to
  /// each element in the collection.
  ///
  /// `null` values are not counted.
  double sumBy(num selector(K key, V value)) {
    return entries.sumBy((entry) => selector(entry.key, entry.value));
  }

  /// Returns an average values returned by [selector] for all elements in
  /// the collection.
  ///
  /// `null` values are counted as 0. Empty collections return null.
  double averageBy(num selector(K key, V value)) {
    return entries.averageBy((entry) => selector(entry.key, entry.value));
  }

  /// Returns the number of elements matching the given [predicate].
  ///
  /// If no [predicate] is given, this equals [length].
  int count([bool predicate(K key, V value)]) {
    return entries.count(
      predicate != null ? (entry) => predicate(entry.key, entry.value) : null,
    );
  }

  /// Returns a new lazy [$Iterable] with all elements which are not null.
  $Map<K, V> where(bool predicate(K key, V value)) {
    return entries.where((entry) => predicate(entry.key, entry.value)).toMap();
  }

  /// Returns a new Map with entries having the keys obtained by applying the
  /// transform function to each entry in this Map and the values of this map.
  ///
  /// In case if any two entries are mapped to the equal keys, the value of the
  /// latter one will overwrite the value associated with the former one.
  ///
  /// The returned map preserves the entry iteration order of the original map.
  $Map<R, V> mapKeys<R>(R transform(K key, V value)) {
    return entries
        .map((entry) => MapEntry(transform(entry.key, entry.value), entry.key))
        .toMap();
  }

  /// Returns a new map with entries having the keys of this map and the values
  /// obtained by applying the transform function to each entry in this Map.
  ///
  /// The returned map preserves the entry iteration order of the original map.
  $Map<R, V> mapValues<R>(R transform(K key, V value)) {
    return entries
        .map(
            (entry) => MapEntry(transform(entry.key, entry.value), entry.value))
        .toMap();
  }

  /// Returns a new lazy [$Iterable] containing only the non-null results of
  /// applying the given [transform] function to each element in the original
  /// collection.
  $Map<K, V> mapNotNull<RK, RV>(MapEntry<RK, RV> transform(K key, V value)) {
    return entries
        .mapNotNull((entry) => transform(entry.key, entry.value))
        .toMap();
  }

  /// Returns a new lazy [$Iterable] containing only elements from the collection
  /// having distinct keys returned by the given [selector] function.
  ///
  /// The elements in the resulting list are in the same order as they were in
  /// the source collection.
  $Map<K, V> distinctBy<R>(R selector(K key, V value)) {
    return entries
        .distinctBy((entry) => selector(entry.key, entry.value))
        .toMap();
  }
}
