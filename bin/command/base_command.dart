import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:package_config/package_config.dart';
import 'package:prepare/log.dart';

import '../components/prepare_yaml.dart';
import '../components/prepare_manager.dart';

abstract class BaseCommand extends Command {
  @override
  Future<void> run() async {
    final packageConfig = await findPackageConfig(Directory.current);
    if (packageConfig == null) {
      error("No package configuration found in the current directory.");
    }

    final yamls = PrepareManager.getYamls(packageConfig!);
    if (yamls.isEmpty) {
      error("No builders were found in the current package configuration.");
    }

    // Run all builders concurrently.
    await Future.wait(yamls.map(start));
  }

  /// Starts a builder process based on the given YAML configuration.
  Future<void> start(PrepareYaml yaml) async {
    final command = getCommand(yaml);
    final parts = command.split(' ');

    // Start the process asynchronously.
    final process = await Process.start(parts.first, parts.sublist(1));

    // Stream stdout in real-time to the console.
    process.stdout.transform(utf8.decoder).listen((data) {
      stdout.write(data);
    });

    // Stream stderr in real-time to the console.
    process.stderr.transform(utf8.decoder).listen((data) {
      stderr.write(data);
    });

    // Wait for the process to finish.
    await process.exitCode;
  }

  // Returns how to generate the command string from a YAML.
  String getCommand(PrepareYaml yaml);
}
