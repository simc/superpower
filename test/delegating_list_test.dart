import 'dart:math';

import 'package:superpower/superpower.dart';
import 'package:test/test.dart';

$List<int> get empty => $List<int>();

void main() {
  test('test []', () {
    var list = $([0, 1, 2, 3, 4]);
    expect(list[0], 0);
    expect(list[2], 2);
    list[2] = 10;
    expect(list[2], 10);
  });

  test('test add', () {
    var list = $([0, 1, 2, 3, 4]);
    list.add(5);
    expect(list, [0, 1, 2, 3, 4, 5]);
  });

  test('test addAll', () {
    var list = $([0, 1, 2, 3, 4]);
    list.addAll([5, 5, 5]);
    expect(list, [0, 1, 2, 3, 4, 5, 5, 5]);
  });

  test('test asMap', () {
    var list = $(['0', '1', '2']);
    expect(list.asMap(), {0: '0', 1: '1', 2: '2'});
  });

  test('test clear', () {
    var list = $([0, 1, 2, 3, 4]);
    list.clear();
    expect(list, <int>[]);
  });

  test('test fillRange', () {
    var list = $([0, 1, 2, 3, 4]);
    list.fillRange(1, 4, 9);
    expect(list, [0, 9, 9, 9, 4]);
  });

  test('test first', () {
    var list = $([0, 1, 2, 3, 4]);
    list.first = 5;
    expect(list.first, 0);
  });

  test('test getRange', () {
    var list = $([0, 1, 2, 3, 4]);
    var result = list.getRange(1, 4);
    expect(result, [1, 2, 3]);
    expect(result is $Iterable, true);
  });

  test('test indexOf', () {
    var list = $(['0', '1', '2', '3', '4']);
    expect(list.indexOf('2'), 2);
  });

  test('test indexWhere', () {
    var list = $(['0', '1', '2', '3', '4']);
    expect(list.indexWhere((e) => e == '2'), 2);
  });

  test('test insert', () {
    var list = $([0, 1, 2, 3, 4]);
    list.insert(2, 5);
    expect(list, [0, 1, 5, 2, 3, 4]);
  });

  test('test insertAll', () {
    var list = $([0, 1, 2]);
    list.insertAll(1, [5, 5, 5]);
    expect(list, [0, 5, 5, 5, 1, 2]);
  });

  test('test last', () {
    var list = $([0, 1, 2, 3, 4]);
    list.last = 5;
    expect(list.last, 5);
  });

  test('test lastIndexOf lastIndexWhere', () {
    var list = $([0, 1, 2, 3, 4, 2, 3, 2, 4]);
    expect(list.lastIndexOf(2, 8), 7);
    expect(list.lastIndexWhere((e) => e == 2, 8), 7);
  });

  test('test length', () {
    var list = $([0, 1, 2, 3, 4]);
    list.length = 2;
    expect(list.length, 2);
  });

  test('test remove', () {
    var list = $([0, 1, 2, 3, 2]);
    list.remove(2);
    expect(list, [0, 1, 3, 2]);
  });

  test('test removeAt', () {
    var list = $([0, 1, 2, 3, 2]);
    list.removeAt(3);
    expect(list, [0, 1, 2, 2]);
  });

  test('test removeLast', () {
    var list = $([0, 1, 2, 3, 2]);
    list.removeLast();
    expect(list, [0, 1, 2, 3]);
  });

  test('test removeRange', () {
    var list = $([0, 1, 2, 3, 4]);
    list.removeRange(1, 4);
    expect(list, [0, 4]);
  });

  test('test removeWhere', () {
    var list = $([0, 1, 2, 3, 4]);
    list.removeWhere((e) => e < 3);
    expect(list, [3, 4]);
  });

  test('test replaceRange', () {
    var list = $([0, 1, 2, 3, 4]);
    list.replaceRange(1, 4, [5, 5]);
    expect(list, [0, 5, 5, 4]);
  });

  test('test retainWhere', () {
    var list = $([0, 1, 2, 3, 4]);
    list.retainWhere((e) => e != 2);
    expect(list, [0, 1, 3, 4]);
  });

  test('test reversed', () {
    var list = $([0, 1, 2, 3, 4]);
    var result = list.reverse();
    expect(result, [4, 3, 2, 1, 0]);
    expect(result is $Iterable, true);
  });

  test('test setAll', () {
    var list = $([0, 1, 2, 3, 4]);
    list.setAll(1, [5, 5, 5]);
    expect(list, [0, 5, 5, 5, 4]);
  });

  test('test setRange', () {
    var list = $([0, 1, 2, 3, 4]);
    list.setRange(1, 2, [5, 5, 5]);
    expect(list, [0, 5, 2, 3, 4]);
  });

  test('test shuffle', () {
    var baseList = [0, 1, 2, 3, 4];
    var list = $(baseList);
    var random = Random();
    baseList.shuffle(random);
    list.shuffle(random);
    expect(list, baseList);
  });

  test('test sort', () {
    var list = $([3, 0, 2, 1, 4]);
    list.sort();
    expect(list, [0, 1, 2, 3, 4]);
  });

  test('test sublist', () {
    var list = $([0, 1, 2, 3, 4]);
    var result = list.sublist(1, 4);
    expect(result, [1, 2, 3]);
    expect(result is $List, true);
  });
}
