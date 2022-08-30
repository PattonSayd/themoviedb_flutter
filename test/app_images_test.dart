import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:the_movie/resources/resources.dart';

void main() {
  test('app_images assets test', () {
    expect(File(AppImages.helo).existsSync(), true);
  });
}
