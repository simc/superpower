import 'package:superpower/superpower.dart';
import 'package:test/test.dart';

$Iterable<E> $it<E>(List<E> elements) => $Iterable(elements).toIterable();
$Iterable<int> get $empty => $List<int>();
$Iterable<int> get $itEmpty => $Iterable<int>.empty();

void testElementAtOrElse($Iterable<int> empty, $Iterable<int> elements) {
  expect(elements.elementAtOrElse(2, (_) => null), 2);
  expect(elements.elementAtOrElse(4, (i) => i), 4);

  expect(empty.elementAtOrElse(1, (i) => i), 1);
  expect(empty.elementAtOrElse(0, (i) => i), 0);
}

void testDrop($Iterable<int> empty, $Iterable<int> elements) {
  {
    var result = empty.drop(3);
    expect(result, empty);
  }
  {
    var result = elements.drop(0);
    expect(result, elements);
  }
  {
    var result = elements.drop(4);
    expect(result, [4, 5, 6]);
  }
  {
    var result = elements.drop(10);
    expect(result, <int>[]);
  }
}
