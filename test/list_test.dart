import 'package:superpower/superpower.dart';
import 'package:test/test.dart';

$List<int> get empty => $List<int>();

void main() {
  test("test new List", () {
    var elements = [1, 2, 3, 4, 5];
    var iterable = $it(elements).toIterable();

    expect($List(elements) is $List, true);
    expect($(elements) is $List, true);

    expect($List(iterable) is $List, true);
    expect($(iterable) is $List, true);

    expect($List(elements), elements);
    expect($(elements), elements);
  });

  test("test List.withLength()", () {
    expect($List<int>.withLength(0).length, 0);
    expect($List<int>.withLength(5).length, 5);
    expect(() => $List<int>.withLength(5, growable: false).add(4),
        throwsUnsupportedError);

    var growable = $List<int>.withLength(5, growable: true)..add(5);
    expect(growable[5], 5);
  });

  test("test List.filled()", () {
    expect($List<int>.filled(0, 1), empty);
    expect($List<int>.filled(5, 2), [2, 2, 2, 2, 2]);
  });

  test("test List.generate()", () {
    expect($List<int>.generate(0, (i) => i), empty);
    expect($List<int>.generate(5, (i) => i), [0, 1, 2, 3, 4]);
  });

  test("test List.generate()", () {
    expect($List<int>.generate(0, (i) => i), empty);
    expect($List<int>.generate(5, (i) => i), [0, 1, 2, 3, 4]);
  });

  test("test lastIndex", () {
    expect(empty.lastIndex, -1);
    expect($List<int>.withLength(10).lastIndex, 9);
  });

  test("test second third fourth", () {
    var list = $([0, 1, 2, 3]);
    expect(list.second, 1);
    expect(list.third, 2);
    expect(list.fourth, 3);
  });

  test("test get", () {
    var list = $([0, 1, 2, 3]);
    expect(list[1], 1);
    expect(() => list[4], throwsRangeError);
    expect(list[-1], 3);
    expect(list[-4], 0);
    expect(() => list[-5], throwsRangeError);
  });

  test("test set", () {
    {
      var list = $([0, 1, 2, 3]);
      list[1] = 3;
      expect(list[1], 3);
    }
    {
      var list = $([0, 1, 2, 3]);
      expect(() => list[4] = 3, throwsRangeError);
    }
    {
      var list = $([0, 1, 2, 3]);
      list[-1] = 0;
      expect(list[3], 0);
    }
    {
      var list = $([0, 1, 2, 3]);
      list[-4] = 3;
      expect(list[0], 3);
    }
    {
      var list = $([0, 1, 2, 3]);
      expect(() => list[-5] = 3, throwsRangeError);
    }
  });

  test("test elementAtOrElse", () {
    var elements = $([0, 1, 2, 3]);
    expect(elements.elementAtOrElse(2, (_) => null), 2);
    expect(elements.elementAtOrElse(4, (i) => i), 4);

    expect(empty.elementAtOrElse(1, (i) => i), 1);
    expect(empty.elementAtOrElse(0, (i) => i), 0);
  });

  test("test dropLast", () {
    var elements = $([0, 1, 2, 3, 4, 5, 6]);
    {
      var result = elements.dropLast(0);
      expect(result, elements);
    }
    {
      var result = elements.dropLast(4);
      expect(result, [0, 1, 2]);
    }
    {
      var result = elements.dropLast(10);
      expect(result, <int>[]);
    }
  });

  test("test dropLastWhile", () {
    var elements = $([0, 1, 2, 3, 4, 5, 6]);
    {
      var result = elements.dropLastWhile((_) => false);
      expect(result, elements);
    }
    {
      var result = elements.dropLastWhile((it) => it >= 3);
      expect(result, [0, 1, 2]);
    }
    {
      var result = elements.dropLastWhile((_) => true);
      expect(result, <int>[]);
    }
  });
}
