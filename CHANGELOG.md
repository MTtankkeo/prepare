## 1.0.0
- Initial version.

## 1.1.0
- Updated `PrepareWatchCommand` to enhance file change detection and rebuild handling.

## 1.1.1
- Fixed an issue where watch mode could fail if files were locked by another process.

## 1.1.2
- Added `PrepareDebounce` utility to debounce rapid successive calls, ensuring only a single execution occurs within the specified delay.

- Updated `PrepareQueue.delayDuration` from 1ms to 10ms to provide more reliable handling of rapid file events.
