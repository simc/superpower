part of superpower;

class _$DelegatingMap<K, V> extends DelegatingMap<K, V> {
  /// Source of the wrapper.
  final Map<K, V> source;

  _$DelegatingMap._(this.source) : super(source);

  @override
  $Iterable<MapEntry<K, V>> get entries => $Iterable(source.entries);

  @override
  $Iterable<K> get keys => $Iterable(source.keys);

  @override
  $Iterable<V> get values => $Iterable(source.values);

  @override
  $Map<K2, V2> map<K2, V2>(MapEntry<K2, V2> transform(K key, V value)) =>
      $Map(super.map(transform));

  $Map<K2, V2> cast<K2, V2>() => $Map(super.cast<K2, V2>());
}
