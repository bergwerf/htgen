// Copyright (c) 2017, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

part of htgen.dynamic;

/// Unpack given [list] of DOM nodes into [target].
void _unpackElementList(List list, List<Node> target) {
  for (final elm in list) {
    if (elm is Node) {
      target.add(elm);
    } else if (elm is List) {
      _unpackElementList(elm, target);
    } else {
      throw new Exception('illegal element type');
    }
  }
}

/// Assign properties to DOM element.
T _createElement<T extends Element>(
    Element element, pArgs, Map<String, String> attrs, List<Node> c) {
  final children = new List<Node>.from(c ?? []);

  // Add attributes.
  element.attributes.addAll(attrs ?? {});

  // Local helper for selector parsing.
  var parsedSelector = false;
  void tryParseSelector(String str) {
    if (!parsedSelector) {
      final sel = parseSelectorString(str);
      if (sel.valid) {
        element.classes.addAll(sel.classes);
        if (sel.id != null) {
          element.id = sel.id;
        }
        parsedSelector = true;
      } else {
        element.text = str;
      }
    } else {
      element.text = str;
    }
  }

  // Process positional arguments.
  if (pArgs is List) {
    for (var i = 0; i < pArgs.length; i++) {
      final arg = pArgs[i];
      if (arg is String) {
        if (i == 0) {
          tryParseSelector(arg);
        } else {
          element.text = arg;
        }
      } else if (arg is Node) {
        children.add(arg);
      } else if (arg is List) {
        _unpackElementList(arg, children);
      } else {
        throw new Exception('illegal element type');
      }
    }
  } else if (pArgs is String) {
    // Interpreted as selector or inner text (fallback).
    tryParseSelector(pArgs);
  } else if (pArgs is Node) {
    // Interpreted as single child node.
    children.add(pArgs);
  } else {
    throw new Exception('illegal argument type');
  }

  // Add all children that are not null.
  children.where((c) => c != null).forEach(element.append);

  return element;
}

typedef T ElementBuilder<T>(pArgs,
    {Map<String, String> attrs, List<Element> c, EventListener onClick});

/// Create element builder.
ElementBuilder<T> _getElementBuilder<T extends Element>(String tag) {
  return (pArgs,
      {Map<String, String> attrs, List<Element> c, EventListener onClick}) {
    final element = _createElement(new Element.tag(tag), pArgs, attrs, c);
    if (onClick != null) {
      element.onClick.listen(onClick);
    }
    return element;
  };
}
