// class A {
//   final String name;
//   A({
//     required this.name,
//   });

//   @override
//   bool operator ==(Object other) {
//     if (identical(this, other)) return true;

//     return other is A && other.name == name;
//   }

//   @override
//   int get hashCode => name.hashCode;
// }

// class B extends A {
//   final int age;
//   B({
//     required super.name,
//     required this.age,
//   });

//   @override
//   bool operator ==(Object other) {
//     return other is B && other.age == age && name == other.name;
//   }

//   @override
//   int get hashCode => age.hashCode ^ super.name.hashCode;
// }

// class C {
//   final int age;
//   final String name;
//   const C(this.age, this.name);
// }

class Test<S> {
  S _state;
  Test(this._state);

  S get state => _state;

  void compare(S state) {
    if (state == _state) return;
    _state = state;
  }
}

abstract class PersonBase {
  const PersonBase();
}

class Person extends PersonBase {
  final String name;
  final int age;
  const Person({
    required this.name,
    required this.age,
  });
}
