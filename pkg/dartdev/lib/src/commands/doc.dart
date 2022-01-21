// Copyright (c) 2021, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:io' as io;

import 'package:dartdoc/dartdoc.dart';
import 'package:dartdoc/options.dart';
import 'package:path/path.dart' as path;

import '../core.dart';
import '../sdk.dart';

/// A command to generate documentation for a project.
class DocCommand extends DartdevCommand {
  static const String cmdName = 'doc';

  static const String cmdDescription = '''
Generate API documentation for Dart projects.

For additional documentation generation options, see the 'dartdoc_options.yaml' file documentation at https://dart.dev/go/dartdoc-options-file.''';

  DocCommand({bool verbose = false}) : super(cmdName, cmdDescription, verbose) {
    argParser.addOption(
      'output',
      abbr: 'o',
      valueHelp: 'directory',
      defaultsTo: path.join('doc', 'api'),
      aliases: [
        // The CLI option that shipped with Dart 2.16.
        'output-dir',
      ],
      help: 'Configure the output directory.',
    );
    argParser.addFlag(
      'validate-links',
      negatable: false,
      help: 'Display warnings for broken links.',
    );
  }

  @override
  String get invocation => '${super.invocation} <input directory>';

  @override
  FutureOr<int> run() async {
    // At least one argument, the input directory, is required.
    if (argResults.rest.isEmpty) {
      usageException("Error: Input directory not specified");
    }

    // Determine input directory.
    final dir = io.Directory(argResults.rest[0]);
    if (!dir.existsSync()) {
      usageException("Error: Input directory doesn't exist: ${dir.path}");
    }

    // Specify where dartdoc resources are located.
    final resourcesPath =
        path.absolute(sdk.sdkPath, 'bin', 'resources', 'dartdoc', 'resources');

    // Build options.
    final options = [
      '--input=${dir.path}',
      '--output=${argResults['output']}',
      '--resources-dir=$resourcesPath',
      if (argResults['validate-links']) '--validate-links'
    ];

    final config = await parseOptions(pubPackageMetaProvider, options);
    if (config == null) {
      // There was an error while parsing options.
      return 2;
    }

    // Call into package:dartdoc.
    if (verbose) {
      log.stdout('Using the following options: $options');
    }
    final packageConfigProvider = PhysicalPackageConfigProvider();
    final packageBuilder = PubPackageBuilder(
        config, pubPackageMetaProvider, packageConfigProvider);
    final dartdoc = config.generateDocs
        ? await Dartdoc.fromContext(config, packageBuilder)
        : await Dartdoc.withEmptyGenerator(config, packageBuilder);
    dartdoc.executeGuarded();
    return 0;
  }
}
