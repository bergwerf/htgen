// Copyright (c) 2017, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

import 'dart:html';

import 'package:htgen/dynamic.dart';

void main() {
  document.body.append(div('#div.my-class', c: [
    span('#id.class', attrs: {'for': 'you'}),
    span(['.spannnn', 'Hello, World!']),
    div(['Some text', span(button('Hi there')), button('Click me!')]),
    div(['#mydiv', 'More text', span(button('Hi there')), button('Click me!')])
  ]));
}
