import 'dart:io';

import 'package:package_config/package_config.dart';
import 'package:yaml/yaml.dart';

import 'prepare_yaml.dart';

class PrepareManager {
  static List<PrepareYaml> getYamls(PackageConfig config) {
    final builders = <PrepareYaml>[];

    for (final package in config.packages) {
      final yamlPaths = [
        "${package.root.toFilePath()}/prepare.yaml",
        "${package.root.toFilePath()}/prepare.yml",
      ];

      final yamlFiles = yamlPaths.map((path) => File(path));
      final existsFiles = yamlFiles.where((file) => file.existsSync());

      if (existsFiles.isNotEmpty) {
        final text = existsFiles.first.readAsStringSync();
        final yaml = loadYaml(text);

        builders.add(
          PrepareYaml(
            runBuild: yaml["builder"]["run_build"],
            runWatch: yaml["builder"]["run_watch"],
          ),
        );
      }
    }

    return builders;
  }
}
