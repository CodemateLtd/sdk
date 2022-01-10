// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/*library: 
 compilationSequence=[
  package:macro_builder/src/macro.dart,
  main.dart|package:macro_builder/macro_builder.dart],
 declaredMacros=[MyMacro],
 macrosAreAvailable
*/

import 'package:macro_builder/macro_builder.dart';

class MyMacro implements Macro {}

void main() {}
