part of superpower;

class _$LazyList<E> extends $List<E> {
  Iterable<E> _iterableSource;
  List<E> _listSource;

  _$LazyList._(this._iterableSource) : super._(_iterableSource);

  @override
  List<E> get source {
    if (_listSource == null) {
      _listSource = _createList();
    }
    return _listSource;
  }

  List<E> _createList() => _iterableSource.toList();
}
