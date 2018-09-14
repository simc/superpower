part of superpower;

/// Creates a [$Map] from given [map].
///
/// If [map] is omitted, an empty list is returned.
$Map<K, V> $map<K, V>([Map<K, V> map]) => $Map(map);

/// Wrapper for [Map].
class $Map<K, V> extends _$DelegatingMap<K, V> {
  $Map._(Map<K, V> source) : super._(source);

  /// Creates a [$Map] from given [map].
  ///
  /// If [map] is omitted, an empty list is returned.
  factory $Map([Map<K, V> map]) {
    return $Map._(map ?? Map<K, V>());
  }

  /// Returns the value for the given [key] or `null` if key is not in the map.
  V get(K key) => this[key];

  /// Returns the value for the given [key] or `defaultValue` if key is not in
  /// the map.
  V getOrDefault(K key, V defaultValue) => this[key] ?? defaultValue;

  /// Returns true if no entries match the given [predicate] and if the map is
  /// not empty.
  bool any(bool predicate(K key, V value)) {
    for (var entry in entries) {
      if (predicate(entry.key, entry.value)) {
        return true;
      }
    }
    return false;
  }

  /// Returns true if no entries match the given [predicate] or if the map is
  /// empty.
  bool all(bool predicate(K key, V value)) {
    for (var entry in entries) {
      if (!predicate(entry.key, entry.value)) {
        return false;
      }
    }
    return true;
  }

  /// Returns true if no entries match the given [predicate] or if the map is
  /// empty.
  bool none(bool predicate(K key, V value)) => !any(predicate);

  /// Performs the given [action] on each entry, providing sequential index
  /// with key and value.
  void forEachIndexed(void action(K key, V value, int index)) {
    var index = 0;
    for (var entry in this.entries) {
      action(entry.key, entry.value, index++);
    }
  }

  /// Returns true if this map is structurally equal to the [other] map.
  ///
  /// I.e. contain the same number of the same entries. The entries don't have
  /// to be in the same order.
  ///
  /// If [checkEqual] is provided, it is used to check if two entries are the
  /// same.
  bool contentEquals(Map<K, V> other,
      [bool checkEqual(MapEntry<K, V> a, MapEntry<K, V> b)]) {
    if (length != other.length) return false;
    if (checkEqual == null) {
      return all((k, v) => other[k] == v);
    } else {
      return entries.all((entry) {
        return other.entries.any((otherEntry) {
          return checkEqual(entry, otherEntry);
        });
      });
    }
  }

  /// Creates a string from all the entries separated using [separator] and
  /// using the given [prefix] and [postfix] if supplied.
  ///
  /// If the map could be huge, you can specify a non-negative value of [limit],
  /// in which case only the first [limit] entries will be appended, followed by
  /// the [truncated] string (which defaults to `"..."`).
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
      transform: transform != null ? mapT : null,
      prefix: prefix,
      postfix: postfix,
      limit: limit,
      truncated: truncated,
    );
  }

  /// Returns the sum of all values produced by [selector] function applied to
  /// each entry in the map.
  ///
  /// `null` values are not counted.
  double sumBy(num selector(K key, V value)) {
    return entries.sumBy((entry) => selector(entry.key, entry.value));
  }

  /// Returns the average of values returned by [selector] for all entries in
  /// the map.
  ///
  /// Empty maps return `null`.
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

  /// Returns a new [Map] with entries having the keys obtained by applying the
  /// [transform] function to each entry in this map and the values of this map.
  ///
  /// In case if any two entries are mapped to the equal keys, the value of the
  /// latter one will overwrite the value associated with the former one.
  ///
  /// The returned map preserves the entry iteration order of the original map.
  $Map<R, V> mapKeys<R>(R transform(K key, V value)) {
    return entries
        .map(
            (entry) => MapEntry(transform(entry.key, entry.value), entry.value))
        .toMap();
  }

  /// Returns a new [$Map] with entries having the keys of this map and the values
  /// obtained by applying the transform function to each entry in this map.
  ///
  /// The returned map preserves the entry iteration order of the original map.
  $Map<K, R> mapValues<R>(R transform(K key, V value)) {
    return entries
        .map((entry) => MapEntry(entry.key, transform(entry.key, entry.value)))
        .toMap();
  }

  /// Returns a new [$Map] containing only the non-null results of applying the
  /// given [transform] function to each entry in the original map.
  $Map<K2, V2> mapNotNull<K2, V2>(MapEntry<K2, V2> transform(K key, V value)) {
    return entries
        .mapNotNull((entry) => transform(entry.key, entry.value))
        .toMap();
  }
}
