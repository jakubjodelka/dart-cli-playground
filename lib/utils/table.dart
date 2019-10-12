// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
//
// https://github.com/dart-lang/dart2js_info/blob/master/lib/src/table.dart

import 'dart:math' show max;

class Table {
  int _totalColumns = 0;

  int get totalColumns => _totalColumns;
  Map<String, String> abbreviations = {};
  List<int> widths = <int>[];
  List header = [];
  List colors = [];
  List<List> rows = [];
  bool _sealed = false;
  List _currentRow;

  void declareColumn(String name,
      {bool abbreviate: false, String color: _NO_COLOR}) {
    assert(!_sealed);
    var headerName = name;
    if (abbreviate) {
      // abbreviate the header by using only the initials of each word
      headerName =
          name.split(' ').map((s) => s.substring(0, 1).toUpperCase()).join('');
      while (abbreviations[headerName] != null) headerName = "$headerName'";
      abbreviations[headerName] = name;
    }
    widths.add(max(5, headerName.length + 1));
    header.add(headerName);
    colors.add(color);
    _totalColumns++;
  }

  void addEntry(entry) {
    if (_currentRow == null) {
      _sealed = true;
      _currentRow = [];
    }
    int pos = _currentRow.length;
    assert(pos < _totalColumns);

    widths[pos] = max(widths[pos], '$entry'.length + 1);
    _currentRow.add('$entry');

    if (pos + 1 == _totalColumns) {
      rows.add(_currentRow);
      _currentRow = [];
    }
  }

  void addEmptyRow() {
    var emptyRow = [];
    for (int i = 0; i < _totalColumns; i++) {
      emptyRow.add('-' * widths[i]);
    }
    rows.add(emptyRow);
  }

  void addHeader() {
    rows.add(header);
  }

  String toString() {
    var sb = new StringBuffer();
    sb.write('\n');
    for (var row in rows) {
      var lastColor = _NO_COLOR;
      for (int i = 0; i < _totalColumns; i++) {
        var entry = row[i];
        var color = colors[i];
        if (lastColor != color) {
          sb.write(color);
          lastColor = color;
        }
        sb.write(
            i == 0 ? entry.padRight(widths[i]) : entry.padLeft(widths[i] + 1));
      }
      if (lastColor != _NO_COLOR) sb.write(_NO_COLOR);
      sb.write('\n');
    }
    return sb.toString();
  }
}

const _NO_COLOR = "\x1b[0m";
