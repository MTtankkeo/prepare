import 'dart:async';

/// A simple debounce utility to delay execution of a callback,
/// ensuring that rapid successive calls within [delayDuration]
/// only result in a single execution.
class PrepareDebounce {
  PrepareDebounce({
    this.delayDuration = const Duration(milliseconds: 10),
  });

  /// The duration to wait before executing the callback.
  final Duration delayDuration;

  /// Internal timer used to track the debounce delay.
  Timer? _debounceTimer;

  /// Schedules the [callback] to run after [delayDuration].
  /// If called again before the timer expires, the previous
  /// scheduled callback is cancelled.
  void run(void Function() callback) {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(delayDuration, callback);
  }
}
