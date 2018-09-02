part of superpower;

class _$DelegatingList<E> extends $Iterable<E> implements List<E> {
  @override
  List<E> get source => super.source as List<E>;

  _$DelegatingList._(Iterable<E> source) : super._(source);

  @override
  E operator [](int index) {
    index = _allowNegativeIndex(index);
    return source[index];
  }

  @override
  void operator []=(int index, E value) {
    index = _allowNegativeIndex(index);
    source[index] = value;
  }

  @override
  void add(E value) {
    source.add(value);
  }

  @override
  void addAll(Iterable<E> iterable) {
    source.addAll(iterable);
  }

  @override
  Map<int, E> asMap() => source.asMap();

  @override
  void clear() {
    source.clear();
  }

  @override
  void fillRange(int start, int end, [E fillValue]) {
    start = _allowNegativeIndex(start);
    end = _allowNegativeIndex(end);
    source.fillRange(start, end, fillValue);
  }

  @override
  set first(E value) {
    source.first = value;
  }

  @override
  $Iterable<E> getRange(int start, int end) {
    start = _allowNegativeIndex(start);
    end = _allowNegativeIndex(end);
    return $Iterable(source.getRange(start, end));
  }

  @override
  int indexOf(E element, [int start = 0]) {
    start = _allowNegativeIndex(start);
    return source.indexOf(element, start);
  }

  @override
  int indexWhere(bool Function(E element) test, [int start = 0]) {
    start = _allowNegativeIndex(start);
    return source.indexWhere(test, start);
  }

  @override
  void insert(int index, E element) {
    index = _allowNegativeIndex(index);
    source.insert(index, element);
  }

  @override
  void insertAll(int index, Iterable<E> iterable) {
    index = _allowNegativeIndex(index);
    source.insertAll(index, iterable);
  }

  @override
  set last(E value) {
    source.last = value;
  }

  @override
  int lastIndexOf(E element, [int start]) {
    start = _allowNegativeIndex(start);
    return source.lastIndexOf(element, start);
  }

  @override
  int lastIndexWhere(bool Function(E element) test, [int start]) {
    start = _allowNegativeIndex(start);
    return source.lastIndexWhere(test, start);
  }

  @override
  set length(int newLength) {
    source.length = newLength;
  }

  @override
  bool remove(Object value) => source.remove(value);

  @override
  E removeAt(int index) {
    index = _allowNegativeIndex(index);
    return source.removeAt(index);
  }

  @override
  E removeLast() => source.removeLast();

  @override
  void removeRange(int start, int end) {
    start = _allowNegativeIndex(start);
    end = _allowNegativeIndex(end);
    source.removeRange(start, end);
  }

  @override
  void removeWhere(bool Function(E element) test) {
    source.removeWhere(test);
  }

  @override
  void replaceRange(int start, int end, Iterable<E> replacement) {
    start = _allowNegativeIndex(start);
    end = _allowNegativeIndex(end);
    source.replaceRange(start, end, replacement);
  }

  @override
  void retainWhere(bool Function(E element) test) {
    source.retainWhere(test);
  }

  @override
  $Iterable<E> get reversed => $Iterable(source.reversed);

  @override
  void setAll(int index, Iterable<E> iterable) {
    index = _allowNegativeIndex(index);
    source.setAll(index, iterable);
  }

  @override
  void setRange(int start, int end, Iterable<E> iterable, [int skipCount = 0]) {
    start = _allowNegativeIndex(start);
    end = _allowNegativeIndex(end);
    source.setRange(start, end, iterable, skipCount);
  }

  @override
  void shuffle([Random random]) {
    source.shuffle(random);
  }

  @override
  void sort([int Function(E a, E b) compare]) {
    source.sort(compare);
  }

  @override
  $List<E> sublist(int start, [int end]) {
    start = _allowNegativeIndex(start);
    end = _allowNegativeIndex(end);
    return $List(source.sublist(start, end));
  }
}
