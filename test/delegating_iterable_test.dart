import 'package:superpower/superpower.dart';
import 'package:test/test.dart';

$Iterable<int> get empty => $Iterable<int>.empty();

$Iterable<E> iterable<E>(List<E> elements) => $Iterable(elements).toIterable();

void main() {
  test('test elementAt', () {
    var elements = iterable([0, 1, 2, 3, 4]);
    expect(elements.elementAt(1), 1);
    expect(elements.elementAt(4), 4);
    expect(elements.elementAt(-1), 4);
    expect(() => elements.elementAt(5), throwsRangeError);
  });

  test('test iterator', () {
    var elements = iterable([0, 1, 2, 3, 4]);
    var i = 0;
    for (var element in elements) {
      expect(elements.elementAt(i++), element);
    }
  });

  test('test length', () {
    expect(empty.length, 0);
    expect(iterable([0, 1, 2, 3, 4]).length, 5);
  });

  test('test followedBy', () {
    var elements = iterable([0, 1, 2, 3, 4]);
    expect(empty.followedBy(empty), empty);
    expect(empty.followedBy(elements), elements);
    expect(elements.followedBy(elements), [0, 1, 2, 3, 4, 0, 1, 2, 3, 4]);
    expect(elements.followedBy([1, 2]) is $Iterable, true);
  });

  test('test map', () {
    var elements = iterable([0, 1, 2, 3, 4]);
    var result = elements.map((e) => e * e);
    expect(result, [0, 1, 4, 9, 16]);
    expect(result is $Iterable, true);
  });

  test('test where', () {
    var elements = iterable([0, 1, 2, 3, 4]);
    var result = elements.where((e) => e > 2);
    expect(result, [3, 4]);
    expect(result is $Iterable, true);
  });

  test('test whereType', () {
    var elements = iterable([0, '1', 2, '3', 4]);
    var result = elements.whereType<int>();
    expect(result, [0, 2, 4]);
    expect(result is $Iterable, true);
  });

  test('test expand', () {
    var elements = iterable([0, 1, 2]);
    var result = elements.expand((e) => [e, e, e]);
    expect(result, [0, 0, 0, 1, 1, 1, 2, 2, 2]);
    expect(result is $Iterable, true);
  });

  test('test toList', () {
    var elements = iterable([0, 1, 2, 3, 4]);
    {
      var result = empty.toList();
      expect(result, <int>[]);
      expect(result is $List, true);
    }
    {
      var result = elements.toList();
      expect(result, [0, 1, 2, 3, 4]);
      expect(result is $List, true);
    }
  });

  test('test take', () {
    var elements = iterable([0, 1, 2, 3, 4]);
    var result = elements.take(3);
    expect(result, [0, 1, 2]);
    expect(result is $Iterable, true);
  });

  test('test takeWhile', () {
    var elements = iterable([0, 1, 2, 3, 4]);
    var result = elements.takeWhile((e) => e < 3);
    expect(result, [0, 1, 2]);
    expect(result is $Iterable, true);
  });

  test('test skip', () {
    var elements = iterable([0, 1, 2, 3, 4]);
    var result = elements.skip(2);
    expect(result, [2, 3, 4]);
    expect(result is $Iterable, true);
  });

  test('test skipWhile', () {
    var elements = iterable([0, 1, 2, 3, 4]);
    var result = elements.skipWhile((e) => e < 3);
    expect(result, [3, 4]);
    expect(result is $Iterable, true);
  });
}
