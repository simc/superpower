import 'package:superpower/superpower.dart';
import 'package:test/test.dart';

void testElementAtOrElse($Iterable<int> empty, $Iterable<int> elements) {
  expect(elements.elementAtOrElse(2, (_) => null), 2);
  expect(elements.elementAtOrElse(4, (i) => i), 4);

  expect(empty.elementAtOrElse(1, (i) => i), 1);
  expect(empty.elementAtOrElse(0, (i) => i), 0);
}
