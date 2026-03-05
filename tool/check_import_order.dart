import 'dart:io';

final RegExp _importRegex = RegExp(r'''^\s*import\s+['"]([^'"]+)['"]\s*;''');

void main(List<String> args) {
  final bool fix = args.contains('--fix');
  final bool verbose = args.contains('--verbose');

  final List<File> files = _collectDartFiles();
  int violations = 0;

  for (final File file in files) {
    final String original = file.readAsStringSync();
    final String updated = _processFile(original, file.path, verbose: verbose);

    if (original != updated) {
      violations++;
      if (fix) {
        file.writeAsStringSync(updated);
      } else {
        stdout.writeln('Import order violation: ${file.path}');
      }
    }
  }

  if (!fix && violations > 0) {
    stderr.writeln(
      'Found $violations file(s) with imports not ordered from shortest to longest.',
    );
    exitCode = 1;
    return;
  }

  if (fix && violations > 0) {
    stdout.writeln('Fixed import order in $violations file(s).');
  } else if (fix) {
    stdout.writeln('No import order changes needed.');
  } else {
    stdout.writeln('Import order check passed.');
  }
}

List<File> _collectDartFiles() {
  const List<String> roots = <String>['lib', 'test', 'tool'];
  final List<File> files = <File>[];

  for (final String root in roots) {
    final Directory dir = Directory(root);
    if (!dir.existsSync()) continue;
    for (final FileSystemEntity entity in dir.listSync(recursive: true)) {
      if (entity is File && entity.path.endsWith('.dart')) {
        files.add(entity);
      }
    }
  }

  files.sort((File a, File b) => a.path.compareTo(b.path));
  return files;
}

String _processFile(String content, String path, {required bool verbose}) {
  final List<String> lines = content.split('\n');
  final int firstImport = lines.indexWhere(
    (String line) => line.trimLeft().startsWith('import '),
  );
  if (firstImport == -1) return content;

  int end = firstImport;
  while (end < lines.length) {
    final String trimmed = lines[end].trim();
    if (trimmed.isEmpty || trimmed.startsWith('import ')) {
      end++;
      continue;
    }
    break;
  }

  final List<String> block = lines.sublist(firstImport, end);
  final List<String> importLines = block
      .where((String line) => line.trimLeft().startsWith('import '))
      .toList();
  if (importLines.length < 2) return content;

  final List<String> sorted = List<String>.from(importLines)
    ..sort((String a, String b) {
      final String uriA = _extractUri(a);
      final String uriB = _extractUri(b);
      final int byLength = uriA.length.compareTo(uriB.length);
      if (byLength != 0) return byLength;
      final int byUri = uriA.compareTo(uriB);
      if (byUri != 0) return byUri;
      return a.compareTo(b);
    });

  bool equal = true;
  for (int i = 0; i < importLines.length; i++) {
    if (importLines[i] != sorted[i]) {
      equal = false;
      break;
    }
  }
  if (equal) return content;

  if (verbose) {
    stdout.writeln('Reordering imports by length in $path');
  }

  final List<String> rewritten = <String>[
    ...lines.sublist(0, firstImport),
    ...sorted,
    ...lines.sublist(end),
  ];
  return rewritten.join('\n');
}

String _extractUri(String line) {
  final RegExpMatch? match = _importRegex.firstMatch(line.trim());
  if (match == null) return line.trim();
  return match.group(1) ?? line.trim();
}
