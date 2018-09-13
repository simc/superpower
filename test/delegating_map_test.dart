import 'package:superpower/superpower.dart';
import 'package:test/test.dart';

void main() {
  test('test entries', () {
    var map = $map({0: '0', 1: '1', 2: '2'});
    expect(map.entries.second.key, 1);
    expect(map.entries.second.value, '1');
    expect(map.entries is $Iterable, true);
  });

  test('test keys', () {
    var map = $map({0: '0', 1: '1', 2: '2'});
    expect(map.keys, [0, 1, 2]);
    expect(map.keys is $Iterable, true);
  });

  test('test values', () {
    var map = $map({0: '0', 1: '1', 2: '2'});
    expect(map.values, ['0', '1', '2']);
    expect(map.values is $Iterable, true);
  });
}
