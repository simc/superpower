import 'package:superpower/superpower.dart';
import 'package:test/test.dart';

import 'common_list_iterable.dart';

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
    testElementAtOrElse(empty, $([0, 1, 2, 3]));
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
