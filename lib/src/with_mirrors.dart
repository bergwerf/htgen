// Copyright (c) 2017, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

part of htgen.static;

class ElementBuilder {
  final String tag, prepend;
  final bool selfClosing;

  ElementBuilder(this.tag, this.prepend, this.selfClosing);

  @override
  dynamic noSuchMethod(Invocation invocation) {
    final classes = new List<String>();
    String id;

    // Parse positional arguments.
    final pArgs = invocation.positionalArguments;
    final children = new List.from(pArgs);

    // If the first argument is a String, try to parse it as a selector. All
    // other arguments are children.
    if (pArgs.isNotEmpty && pArgs.first is String) {
      final sel = parseSelectorString(pArgs.first);
      if (sel.valid) {
        children.removeAt(0);
        classes.addAll(sel.classes);
        id = sel.id;
      }
    }

    // Convert named parameters to String -> String map.
    final named = invocation.namedArguments;
    final attrs = new Map<String, String>.fromEntries(named.entries
        .map((e) => new MapEntry(_symbolToAttributeName(e.key), '${e.value}')));

    // Add parsed ID and classes to attributes.
    if (id != null && id.isNotEmpty) {
      attrs['id'] = id;
    }
    if (classes.isNotEmpty) {
      attrs['class'] = classes.join(' ');
    }

    // Remove children attribute.
    attrs.remove('c');

    // Generate attribute string.
    final akeys = attrs.keys.toList();
    final attrsStr = new List<String>.generate(
        akeys.length, (i) => '${akeys[i]}="${attrs[akeys[i]]}"').join(' ');

    // Assign named parameter child list to children.
    if (named.containsKey(#c)) {
      children.addAll(named[#c]);
    }

    // Process children (that is, collapse lists into each other).
    var containedLists = true;
    while (containedLists) {
      containedLists = false;
      for (var i = 0; i < children.length; i++) {
        if (children[i] != null && children[i] is List) {
          containedLists = true;
          final list = children.removeAt(i);

          // Insert all items of this list at this position,
          // and move the index forward.
          children.insertAll(i, list);
          i += list.length - 1;
        }
      }
    }

    final open = akeys.isEmpty ? tag : '$tag $attrsStr';
    children.removeWhere((c) => c == null || !(c is String));
    if (children.isNotEmpty) {
      return '$prepend<$open>${children.join()}</$tag>';
    } else {
      return selfClosing ? '$prepend<$open>' : '$prepend<$open></$tag>';
    }
  }
}

/// Convert [symbol] to HTML tag attribute name.
String _symbolToAttributeName(Symbol symbol) {
  var name = MirrorSystem.getName(symbol);
  if (name.startsWith('_')) {
    // A starting underscore can be used to include attributes that are
    // also Dart keywords (such as for).
    name = name.substring(1);
  }

  // An underscore is interpreted as dash.
  return name.replaceAll('_', '-');
}

// Element builders for regular elements.
dynamic _getElementBuilder(String tag,
        {String prepend = '', bool selfClosing: false}) =>
    new ElementBuilder(tag, prepend, selfClosing);
