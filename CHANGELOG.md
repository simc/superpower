# 0.4.0
- Fixed wrong sorting order when using `thenBy()` more than once.

## 0.3.2
- Fixed Readme

## 0.3.1
- Added logo to repository
- Fixed docs

## 0.3.0
- **Breaking:** `$Iterable.whereNotNull` -> `$Iterable.whereNotNull()`
- Added `$Map` and `$map()`
- Added `$Iterable.all()`, `$Iterable.toMap()`, `$Iterable.windowed()`
- Added parameter `n` to `$Iterable.cycle()`
- Added more tests
- Fixed wrong naming in docs: ~~`sortBy`~~ is really called `sortedBy` (thanks @bltavares)
- Improved docs and added examples to many functions

## 0.2.0
- Removed `drop()` and `dropWhile()` from `$List` and `$Iterable` (use `skip()` and `skipWhile()` instead)
- Added `$it()` as short form of `$Iterable()`
- Added test cases

## 0.1.3
- Added `$Iterable.joinToString()`, `$Iterable.onEach()` and `$Iterable.shuffled`

## 0.1.2
- Added `$Iterable.mapNotNull()`

## 0.1.1
- Documentation fixes

## 0.1.0
- First release