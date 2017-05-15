// Copyright (c) 2017, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

library htgen.selector_parser;

class Selector {
  String id;
  final classes = new List<String>();
}

Selector parseSelectorString(String str) {
  final sel = new Selector();
  var strCpy = str;

  // Try to parse first argument as class or ID.
  final idPattern = new RegExp(r'#([A-Za-z][0-9A-Za-z-:_-]*)(?:\.|$)');
  final classPattern = new RegExp(r'\.([A-Za-z][0-9A-Za-z-:_-]*)(?:\.|$)');
  final idMatch = idPattern.matchAsPrefix(str);
  if (idMatch != null) {
    sel.id = idMatch.group(1);
    strCpy = strCpy.substring(sel.id.length + 1);
  }

  // Parse classes.
  while (strCpy.isNotEmpty) {
    final classMatch = classPattern.matchAsPrefix(strCpy);

    if (classMatch == null) {
      throw new ArgumentError('invalid selector');
    } else {
      sel.classes.add(classMatch.group(1));
      strCpy = strCpy.substring(sel.classes.last.length + 1);
    }
  }

  return sel;
}
