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
}
