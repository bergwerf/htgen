// Copyright (c) 2017, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

library htgen.dynamic;

import 'dart:html';
import 'dart:svg' as dart_svg;

import 'package:htgen/src/selector_parser.dart';

part 'src/dynamic_element_builder.dart';

final a = _getElementBuilder<AnchorElement>('a');
final body = _getElementBuilder<BodyElement>('body');
final br = _getElementBuilder<BRElement>('br');
final button = _getElementBuilder<ButtonElement>('button');
final code = _getElementBuilder<Element>('code');
final div = _getElementBuilder<DivElement>('div');
final footer = _getElementBuilder<Element>('footer');
final form = _getElementBuilder<FormElement>('form');
final h1 = _getElementBuilder<Element>('h1');
final h2 = _getElementBuilder<Element>('h2');
final h3 = _getElementBuilder<Element>('h3');
final h4 = _getElementBuilder<Element>('h4');
final h5 = _getElementBuilder<Element>('h5');
final h6 = _getElementBuilder<Element>('h6');
final head = _getElementBuilder<HeadElement>('head');
final html = _getElementBuilder<HtmlElement>('html');
final img = _getElementBuilder<ImageElement>('img');
final input = _getElementBuilder<InputElement>('input');
final label = _getElementBuilder<LabelElement>('label');
final li = _getElementBuilder<LIElement>('li');
final link = _getElementBuilder<LinkElement>('link');
final meta = _getElementBuilder<MetaElement>('meta');
final nav = _getElementBuilder<Element>('nav');
final ol = _getElementBuilder<OListElement>('ol');
final option = _getElementBuilder<OptionElement>('option');
final p = _getElementBuilder<ParagraphElement>('p');
final script = _getElementBuilder<ScriptElement>('script');
final select = _getElementBuilder<SelectElement>('select');
final small = _getElementBuilder<Element>('small');
final span = _getElementBuilder<SpanElement>('span');
final style = _getElementBuilder<StyleElement>('style');
final svg = _getElementBuilder<dart_svg.SvgElement>('svg');
final table = _getElementBuilder<TableElement>('table');
final textarea = _getElementBuilder<TableElement>('textarea');
final tbody = _getElementBuilder<TableSectionElement>('tbody');
final td = _getElementBuilder<TableCellElement>('td');
final th = _getElementBuilder<TableCellElement>('th');
final thead = _getElementBuilder<TableSectionElement>('thead');
final title = _getElementBuilder<TitleElement>('title');
final tr = _getElementBuilder<TableRowElement>('tr');
final ul = _getElementBuilder<UListElement>('ul');
