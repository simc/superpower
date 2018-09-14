## 0.3.0
- **Breaking:** `$Iterable.whereNotNull` -> `$Iterable.whereNotNull()`
- Added `$Map` and `$map()`
- Added `$Iterable.all()`, `$Iterable.toMap()`, `$Iterable.windowed()`
- Added parameter `n` to `$Iterable.cycle()`
- Added more tests
- Fix wrong naming in docs: ~~`sortBy`~~ is really called `sortedBy` (thanks @bltavares)
- Improved docs and added examples to many functions

## 0.2.0
- Remove `drop()` and `dropWhile()` from `$List` and `$Iterable` (use `skip()` and `skipWhile()` instead)
- Add `$it()` as short form of `$Iterable()`
- Add test cases

## 0.1.3
- Add `$Iterable.joinToString()`, `$Iterable.onEach()` and `$Iterable.shuffled`

## 0.1.2
- Add `$Iterable.mapNotNull()`

## 0.1.1
- Documentation fixes

## 0.1.0
- First release