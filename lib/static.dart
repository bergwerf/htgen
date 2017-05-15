// Copyright (c) 2017, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

// This is pure pollution of the global namespace, so import as something.
library htgen.static;

import 'dart:mirrors';

import 'package:htgen/src/selector_parser.dart';

part 'src/with_mirrors.dart';

final a = _getElementBuilder('a');
final body = _getElementBuilder('body');
final br = _getElementBuilder('br', selfClosing: true);
final button = _getElementBuilder('button');
final code = _getElementBuilder('code');
final div = _getElementBuilder('div');
final footer = _getElementBuilder('footer');
final form = _getElementBuilder('form');
final h1 = _getElementBuilder('h1');
final h2 = _getElementBuilder('h2');
final h3 = _getElementBuilder('h3');
final h4 = _getElementBuilder('h4');
final h5 = _getElementBuilder('h5');
final h6 = _getElementBuilder('h6');
final head = _getElementBuilder('head');
final html = _getElementBuilder('html', prepend: '<!DOCTYPE html>');
final img = _getElementBuilder('img', selfClosing: true);
final input = _getElementBuilder('input', selfClosing: true);
final label = _getElementBuilder('label');
final li = _getElementBuilder('li');
final link = _getElementBuilder('link');
final meta = _getElementBuilder('meta');
final nav = _getElementBuilder('nav');
final ol = _getElementBuilder('ol');
final option = _getElementBuilder('option');
final p = _getElementBuilder('p');
final script = _getElementBuilder('script');
final select = _getElementBuilder('select');
final small = _getElementBuilder('small');
final span = _getElementBuilder('span');
final style = _getElementBuilder('style');
final svg = _getElementBuilder('svg');
final table = _getElementBuilder('table');
final tbody = _getElementBuilder('tbody');
final td = _getElementBuilder('td');
final th = _getElementBuilder('th');
final thead = _getElementBuilder('thead');
final title = _getElementBuilder('title');
final tr = _getElementBuilder('tr');
final ul = _getElementBuilder('ul');

// Inline SVG.
final svgDefs = _getElementBuilder('defs');
final svgLinearGradient = _getElementBuilder('linearGradient');
final svgStop = _getElementBuilder('stop');

/// Helper for writing style attributes.
String buildStyle(Map<String, dynamic> props) {
  final k = props.keys.toList();
  return new List<String>.generate(
      k.length, (i) => '${k[i]}:${props[k[i]].toString()};').join();
}
