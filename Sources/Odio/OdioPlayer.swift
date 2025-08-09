//
// OdioPlayer.swift
// Odio
//
// Created by Barreloofy on 7/25/25 at 6:31 PM
//

import AVFoundation

/// The underlying type used by Odio as audio player.
public struct OdioPlayer {
  private let player: AVAudioPlayer?
  public var delay: TimeInterval

  /// - Parameters:
  ///   - name: The name of an audio file.
  ///   - delay: The delay in seconds before the player starts playing.
  ///   - bundle: The bundle to retrieve the file from.
  public init(_ name: String, after delay: TimeInterval = 0, from bundle: Bundle = .main) {
    self.player = createPlayer(name: name, bundle: bundle)
    self.delay = delay
  }

  public init() {
    self.player = nil
    self.delay = 0
  }

  public func callAsFunction() {
    guard let player = player else { return }
    player.play(atTime: player.deviceCurrentTime + delay)
  }

  /// Stops playback.
  public func stop() { player?.stop() }

  /// Stops playback and resets playback time to 0.
  public func end() {
    player?.stop()
    player?.currentTime = .zero
  }
}
