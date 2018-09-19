import 'package:superpower/superpower.dart';

class Person {
  String name;
  int age;
  $List<String> hobbies;

  Person(this.name, this.age, this.hobbies);
}

var david = Person("David", 24, $(["biking", "swimming"]));
var linda = Person("Linda", 12, $(["cooking", "friends"]));
var amanda = Person("Amanda", 24, $(["friends", "swimming"]));
var paolo = Person("Paolo", 18, $(["swimming", "cooking"]));

void main() {
  var persons = $([david, linda, amanda, paolo]);

  var averageAge = persons.averageBy((p) => p.age);
  print(averageAge);
  // 19.5

  var hobbies = persons.flatMap((p) => p.hobbies).distinct();
  print(hobbies);
  // ["biking", "swimming", "music", "cooking", "friends"]

  var namesByHobbies = hobbies.associateWith((hobby) {
    return persons.mapNotNull((person) {
      if (person.hobbies.contains(hobby))
        return person.name;
      else
        return null;
    });
  });
  print(namesByHobbies);
  // {
  //   "biking": ["David"],
  //   "swimming": ["David", "Amanda", "Paolo"],
  //   "cooking": ["Linda" "Paolo"],
  //   "friends": ["Linda" "Amanda"]
  // }

  var sorted = persons.sortedBy((p) => p.age).thenByDescending((p) => p.name);
  print(sorted);
  // [Linda, Paolo, David, Amanda]

  var groupedByAge = persons.groupBy((p) => p.age);
  print(groupedByAge);
  // {
  //   12: [Linda],
  //   18: [Paolo],
  //   24: [David, Amanda]
  // }

  var legalAge = persons.partition((p) => p.age >= 21);
  print(legalAge);
  // [
  //  [Linda, Paolo],
  //  [David, Amanda]
  // ]

  var sameHobbies = david.hobbies.intersect(amanda.hobbies);
  print(sameHobbies);
  // ["swimming"]
}
