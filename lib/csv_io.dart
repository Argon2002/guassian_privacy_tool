import 'dart:io';

import 'package:csv/csv.dart';

Future<List<Map<String, String>>> readCsvAsMaps(String csvPath) async {
  final text = await File(csvPath).readAsString();
  final rows = const CsvToListConverter(eol: '\n').convert(text);

  if (rows.isEmpty) {
    return [];
  }

  final headers = rows.first.map((e) => e.toString()).toList();

  final out = <Map<String, String>>[];

  for (int i = 0; i < rows.length; i++) {
    final row = rows[i];
    final m = <String, String>{};

    for (int j = 0; j < headers.length; j++) {
      final v = (j < row.length) ? row[j] : '';
      m[headers[j]] = v.toString();
    }
    out.add(m);
  }
  return out;
}

Future<void> writeMapsAsCsv(
  String path,
  List<Map<String, String>> rows,
  List<String> headers,
) async {
  final data = <List<dynamic>>[];
  data.add(headers);

  for (final row in rows) {
    data.add(headers.map((h) => row[h] ?? '').toList());
  }
  final csv = const ListToCsvConverter().convert(data);
  await File(path).writeAsString(csv);
}
