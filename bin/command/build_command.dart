import 'dart:async';
import 'dart:io';
import 'package:args/command_runner.dart';
import 'package:prepare/log.dart';
import 'package:package_config/package_config.dart';

import '../components/prepare_manager.dart';

/// A CLI command that triggers the datagen build process.
class BuildCommand extends Command {
  @override
  String get name => "build";

  @override
  String get description => "Generates files";

  @override
  Future<void> run() async {
    final packageConfig = await findPackageConfig(Directory.current);
    if (packageConfig == null) {
      throw Exception("");
    }

    final builders = PrepareManager.getBuilders(packageConfig);
    if (builders.isEmpty) {
      throw Exception("");
    }

    final futures = builders.map((builder) async {
      final command = builder.runBuild;
      final parts = command.split(' ');

      await Process.run(parts.first, parts.sublist(1));
    });

    await Future.wait(futures);

    log("Pre-processing build completed successfully!", color: green);
  }
}
