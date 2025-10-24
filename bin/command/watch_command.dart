import 'base_command.dart';
import '../components/prepare_yaml.dart';

/// A CLI command that triggers the prepare watch process.
class WatchCommand extends BaseCommand {
  @override
  String get name => "watch";

  @override
  String get description => "Generates files";

  @override
  String getCommand(PrepareYaml yaml) {
    return yaml.runWatch;
  }
}
