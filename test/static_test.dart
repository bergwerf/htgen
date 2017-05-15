// Copyright (c) 2017, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

import 'package:test/test.dart';
import 'package:htgen/static.dart' as ht;

void main() {
  test('General', () {
    expect(ht.html([ht.head(ht.title('Hi!'))]),
        '<!DOCTYPE html><html><head><title>Hi!</title></head></html>');
    expect(ht.label('You', _for: 'me'), equals('<label for="me">You</label>'));
    expect(ht.div(data_who: 'You'), equals('<div data-who="You"></div>'));
  });
}
