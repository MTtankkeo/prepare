export 'datagen.datagen.dart';
import 'datagen.datagen.dart';

import 'package:datagen/annotation.dart';

@datagen
class A extends $A {
  const A({required String a, required String b, required String c})
    : super(a, b, c);
}
