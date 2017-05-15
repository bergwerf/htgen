Functions for generating HTML
=============================
This library contains functions for generating HTML content. There are two
libraries that you can import. One for server-side HTML generation:
`htgen/static.dart`, and one for dynamic HTML generation: `htgen/dynamic.dart`.
The static generation is basically a function that returns an XML string. Its
nothing more than a mirrors based hack that allows you to write your HTML nodes
as a set of nested functions returned by a Dart function instead of using HTML
templates. The dynamic generation does not use mirrors, but instead are mostly
shortcuts for creating DOM nodes and assigning attributes and children to them.
