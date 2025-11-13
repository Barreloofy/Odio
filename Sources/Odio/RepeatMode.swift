//
// RepeatMode.swift
// Odio
//
// Created by Barreloofy on 8/11/25 at 11:26 PM
//

/// The possible repeat behavior of `OdioPlayer`.
public enum RepeatMode {
  /// Repeats playback never, playback will occur once.
  case never

  /// Repeats playback the specified number of times, playback will occur at least once.
  case repeating(UInt = 0)

  /// Indefinitely plays back audio.
  case loop

  /// Convert `RepeatMode` case into Integer.
  /// Sets `numberOfLoops` of `AVAudioPlayer` to the specified number.
  func numberOfLoops() -> Int {
    switch self {
    case .never:
      0
    case .repeating(let count):
      Int(count)
    case .loop:
      -1
    }
  }
}
