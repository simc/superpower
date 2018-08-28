# Superpowers for Dart
[![Build Status](https://travis-ci.com/leisim/superpower.svg?branch=master)](https://travis-ci.com/leisim/superpower) [![Coverage Status](https://coveralls.io/repos/github/leisim/superpower/badge.svg)](https://coveralls.io/github/leisim/superpower) [![Version](https://img.shields.io/pub/v/superpower.svg)](https://pub.dartlang.org/packages/superpower) ![Runtime](https://img.shields.io/badge/dart-%3E%3D2.0-brightgreen.svg) ![GitHub license](https://img.shields.io/badge/license-MIT-blue.svg?style=flat)

Easy to use wrappers for List and Iterable with many handy functions.

Inspired by Kotlin.

### Resources:
- [Documentation](https://pub.dartlang.org/documentation/superpower/latest/)
- [Pub Package](https://pub.dartlang.org/packages/superpower)
- [GitHub Repository](https://github.com/leisim/superpower)

<br>

# Get started 🎉
Just wrap your existing List with `$List(myList)` or create a new empty list
with `$List()` and you are good to go.
<br>
As a short form you can use `$(myList)` and `$()`.

```dart
var superList = $([1, 10, 2, 9, 3, 8, 4, 7, 5, 6]);
superList
    .slice(2, -2) // [2, 9, 3, 8, 4, 7]
    .whereIndexed((_, index) => index % 2 == 1) // [9, 8, 7]
    .sum(); // 24
```

<br>

# Introduction to superpowers ❤️

## Negative indices
This is one of the coolest features: You can use negative indices which start at
the last element of the list: `list[-1]` is the same as `list[list.length - 1]`.
<br>
Here is how the negative indices work:
```dart
var positiveIndices = $([ '0',  '1',  '2',  '3']);
var negativeIndices = $(['-4', '-3', '-1', '-1']);
//                  Access this ^ item:
var positiveItem = positiveIndices[1];
var negativeItem = negativeIndices[-3];
```

## firstOrNull & firstOrNullWhere
Find the first element of the collection matching a predicate:
```dart
var list = $(['This', 'is', 'a', 'Test']);
var first = list.firstOrNull; // 'This'
var firstWhere = list.firstOrNullWhere((s) => s.length <= 2); // 'is'
var firtNull = list.firstOrNullWhere((s) => s.length > 4); // null
```

## elementAtOrNull & elementAtOrElse
Get the element at an index or null if the index does not exist:
```dart
var list = $([0, 1, 2, 3, 4, 5, 6]);
var second = list.elementAtOrNull(1); // 1
var highIndexNull = list.elementAtOrNull(10); // null
var highIndexDefault = list.elementAtOrDefault(10, -1); // -1
```

## slice
Get a sublist of the collection:
```dart
var list = $([0, 1, 2, 3, 4, 5]);
var last = list.slice(-1); // [5]
var lastHalf = list.slice(3); // [3, 4, 5]
var allButFirstAndLast = list.slice(1,-2); // [1, 2, 3, 4]
```

## drop & dropLast
Get a list containing all elements except first `n` elements:
```dart
var list = $([0, 1, 2, 3, 4, 5]);
var lastElements = list.drop(3); // [3, 4, 5]
var firstElements = list.dropLast(3); // [0, 1, 2]
var middleElements = list.drop(2).dropLast(2); // [2, 3]
```

## contentEquals
Compare two lists:
```dart
var list = $(['some', 'items']);
var equals1 = list.contentEquals(['some', 'items']); // true
var equals2 = list.contentEquals(['SOME', 'items']); // false
```

## sortBy & thenBy
Sort lists by multiple properties
```dart
class Dog {
    String name;
    String age;

    Dog(this.name, this.age);
}

var dogs = $();
dogs.add(Dog("Tom", 3));
dogs.add(Dog("Charlie", 7));
dogs.add(Dog("Charlie", 2));
dogs.add(Dog("Cookie", 4));
dogs.add(Dog("Bark", 1));

var sorted = dogs
    .sortBy((dog) => dog.name)
    .thenByDescending((dog) => dog.age);
// Bark, Cookie, Charlie (7), Charlie (2), Tom
```

## minBy & maxBy
Get the smallest or largest element from a list:
```dart
//Take dogs list from example above
var firstDogByName = dogs.minBy((dog) => dog.name); // Bark
var oldestDog = dogs.maxBy((dog) => dog.age); // Charlie
````

## distinctBy
Get distinct elements from a list:
```dart
//Take dogs list from example above
var dogNames = dogs
    .distinctBy((dog) => dog.name)
    .map((dog) => dog.name);
// ['Tom', 'Charlie', 'Cookie', 'Bark']
```

## flatten
Flatten a list of iterables:
```dart
var nestedList = $List([[1, 2, 3], [4, 5, 6]]);
var flattened = nestedList.flatten(); // [1, 2, 3, 4, 5, 6]
```

## many more superpowers
There are many more handy superpowers (like `intersect()`, `groupBy()` and
`associateWith()`) available. Take a look at the **[Documentation](https://pub.dartlang.org/documentation/superpower/latest/)**.

<br>

# \$List and \$Iterable 🦄
The two wrappers of `List`s and `Iterable`s are `$List` and `$Iterable` they
behave as you would expect them to. (`$Iterable` is lazy loading while `$List`
is not)<br>
There is no need to work with the unwrapped classes. `$List` and `$Iterable`
have the exact same performance as their native counterparts.

<br>

# Todo ✏️
- ✔️ most important features for collections
- even more tests
- superpowers for Map, String etc.
- more features for collections
- more samples in the docs

<br>

## MIT License

Copyright (c) 2018 Simon Leier

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.