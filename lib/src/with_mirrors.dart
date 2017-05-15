// Copyright (c) 2017, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

part of htgen.static;

@proxy
class ElementBuilder {
  final String tag, prepend;
  final bool selfClosing;

  ElementBuilder(this.tag, this.prepend, this.selfClosing);

  String _symbolToAttributeName(Symbol sym) {
    var name = MirrorSystem.getName(sym);
    if (name.startsWith('_')) {
      // A starting underscore can be used to include attributes that are
      // also Dart keywords (such as for).
      name = name.substring(1);
    }

    // An underscore is interpreted as dash.
    name = name.replaceAll('_', '-');

    return name;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) {
    final classes = new List<String>();
    List children = [];
    String id;
    String innerHtml;

    // Parse positional arguments.
    var parsedSelector = false;
    for (final arg in invocation.positionalArguments) {
      if (arg is List) {
        children = arg;
      } else if (arg is String) {
        if (!parsedSelector) {
          try {
            final sel = parseSelectorString(arg);
            classes.addAll(sel.classes);
            id = sel.id;
            parsedSelector = true;
          } catch (e) {
            parsedSelector = true;
            innerHtml = arg;
          }
        } else {
          innerHtml = arg;
        }
      }
    }

    // Convert named parameters to String -> String map.
    final named = invocation.namedArguments;
    final attrs = new Map<String, String>.fromIterable(named.keys,
        key: _symbolToAttributeName, value: (sym) => named[sym].toString());

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
      children = new List.from(named[#c]);
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
    children.removeWhere((c) => c == null);
    if (children.isNotEmpty) {
      return '$prepend<$open>${children.join()}</$tag>';
    } else if (innerHtml != null) {
      return '$prepend<$open>$innerHtml</$tag>';
    } else {
      return selfClosing ? '$prepend<$open>' : '$prepend<$open></$tag>';
    }
  }
}

/// Helper for writing style attributes.
String buildStyle(Map<String, dynamic> props) {
  final k = props.keys.toList();
  return new List<String>.generate(
      k.length, (i) => '${k[i]}:${props[k[i]].toString()};').join();
}

// Element builders for regular elements.
dynamic _getElementBuilder(String tag,
        {String prepend = '', bool selfClosing: false}) =>
    new ElementBuilder(tag, prepend, selfClosing);
