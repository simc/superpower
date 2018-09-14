import 'package:superpower/superpower.dart';
import 'package:test/test.dart';

$Map<String, int> get empty => $Map<String, int>();

void main() {
  test('test get', () {
    var map = $map({'0': 0, '1': 1, '2': 2});
    expect(empty.get('3'), null);
    expect(map.get('1'), 1);
    expect(map.get('3'), null);
  });

  test('test getOrDefault', () {
    var map = $map({'0': 0, '1': 1, '2': 2});
    expect(empty.getOrDefault('3', 4), 4);
    expect(map.getOrDefault('1', 4), 1);
    expect(map.getOrDefault('3', 4), 4);
  });

  test('test any', () {
    var map = $map({'0': 0, '1': 1, '2': 2});
    expect(empty.any((k, v) => false), false);
    expect(map.any((k, v) => v == 1), true);
    expect(map.any((k, v) => v == 3), false);
  });

  test('test all', () {
    var map = $map({'0': 0, '1': 1, '2': 2});
    expect(empty.all((k, v) => false), true);
    expect(map.all((k, v) => v <= 2), true);
    expect(map.all((k, v) => v == 1), false);
  });

  test('test none', () {
    var map = $map({'0': 0, '1': 1, '2': 2});
    expect(empty.none((k, v) => true), true);
    expect(map.none((k, v) => v == 3), true);
    expect(map.none((k, v) => v == 1), false);
  });

  test('test forEachIndexed', () {
    var map = $map({'0': 0, '1': 1, '2': 2});
    empty.forEachIndexed((k, v, i) {
      throw Exception("should not happen");
    });
    var index = 0;
    map.forEachIndexed((k, v, i) {
      expect(k, map.entries.elementAt(i).key);
      expect(v, map.entries.elementAt(i).value);
      expect(i, index++);
    });
    expect(index, 3);
  });

  test('test contentEquals', () {
    var map1 = $map({'0': 0, '1': 1, '2': 2});
    var map2 = $map({'1': 1, '2': 2, '0': 0});
    var map3 = $map({'0': 1, '1': 1, '2': 2});
    var map4 = $map({'0': 0, '1': 1, '3': 2});
    expect(empty.contentEquals(empty), true);
    expect(empty.contentEquals(map1), false);
    expect(map1.contentEquals(empty), false);
    expect(map1.contentEquals(map2), true);
    expect(map2.contentEquals(map1), true);
    expect(map1.contentEquals(map3), false);
    expect(map1.contentEquals(map4), false);
  });

  test('test joinToString', () {
    var map = $map({'0': 0, '1': 1, '2': 2});
    expect(empty.joinToString(), '');
    expect(
        map.joinToString(), 'MapEntry(0: 0), MapEntry(1: 1), MapEntry(2: 2)');
    //expect(map.none((k, v) => v == 1), false);
  });

  test('test sumBy', () {
    var map = $map({'0': 0, '1': 1, '2': 2});
    expect(empty.sumBy((k, v) => 5), 0);
    expect(map.sumBy((k, v) => 5), 15);
    expect(map.sumBy((k, v) => v * v), 5);
  });

  test('test averageBy', () {
    var map = $map({'0': 0, '1': 1, '2': 2});
    expect(empty.averageBy((k, v) => 5), null);
    expect(map.averageBy((k, v) => 5), 5);
    expect(map.averageBy((k, v) => v), 1);
  });

  test('test count', () {
    var map = $map({'0': 0, '1': 1, '2': 2});
    expect(empty.count(), 0);
    expect(map.count(), 3);
    expect(map.count((k, v) => v > 0), 2);
  });

  test('test where', () {
    var map = $map({'0': 0, '1': 1, '2': 2});
  });
}
