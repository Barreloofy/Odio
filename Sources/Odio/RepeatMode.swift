//
// RepeatMode.swift
// Odio
//
// Created by Barreloofy on 8/11/25 at 11:26 PM
//

/// The possible repeat behavior of `OdioPlayer`.
public enum RepeatMode {
  /// Indefinitely plays back audio.
  case loop

  /// Repeats playback the specified number of times, playback will occur at least once.
  case count(UInt = 0)

  /// Convert `RepeatMode` case into Integer.
  /// Sets `numberOfLoops` of `AVAudioPlayer` to the specified number.
  func numberOfLoops() -> Int {
    switch self {
    case .loop: -1
    case .count(let count): Int(count)
    }
  }
}
