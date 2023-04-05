import 'package:flutter_test/flutter_test.dart';
import 'package:the_movie/equal.dart';
import 'package:the_movie/presentation/blocs/auth_cubit/auth_cubit_cubit.dart';

void main() {
  test('----', () {
    const a = Person(name: 'Patton', age: 28);
    const a2 = Person(name: 'Patton', age: 18);

    // final test = Test(const Person(name: 'Patton', age: 18));
    // test.compare(const Person(name: 'Raiden', age: 18));

    print(a == a2);
    print('Hashcode: ${a.hashCode == a2.hashCode}');
    print('RuntimeType: ${a.runtimeType == a2.runtimeType}');

    // var o = new Object();
    // var isIdentical = identical(o, new Object()); // false, different objects.
    // print(isIdentical);
    // var a = 1;
    // var b = 1;
    // print(a == b);
  });
}
