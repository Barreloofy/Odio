//
// OdioPlayer.swift
// Odio
//
// Created by Barreloofy on 7/25/25 at 6:31 PM
//

import AVFoundation

/// The underlying type used by Odio for audio playback.
public struct OdioPlayer {
  /// The underlying `AVAudioPlayer` instance.
  private let player: AVAudioPlayer?

  /// The delay before playback occurs.
  public var delay: TimeInterval

  /// The playback repeat mode to use.
  public var repeatMode: RepeatMode

  /// - Parameters:
  ///   - name: The name of an audio file.
  ///   - delay: The time in seconds before playback occurs.
  ///   - repeatMode: The playback repeat mode to use.
  ///   - bundle: The bundle to retrieve the file from.
  public init(
    _ name: String,
    after delay: TimeInterval = 0,
    repeatMode: RepeatMode = .count(),
    from bundle: Bundle = .main) {
    self.player = createPlayer(name: name, bundle: bundle)
    self.repeatMode = repeatMode
    self.delay = delay
  }

  /// - Parameters:
  ///   - key: The key identifying an audio file.
  ///   - delay: The time in seconds before playback occurs.
  ///   - repeatMode: The playback repeat mode to use.
  ///   - bundle: The bundle to retrieve the file from.
  public init(
    _ key: FileKey,
    after delay: TimeInterval = 0,
    repeatMode: RepeatMode = .count(),
    from bundle: Bundle = .main) {
    self.player = createPlayer(name: key(), bundle: bundle)
    self.repeatMode = repeatMode
    self.delay = delay
  }

  /// Creates an empty `OdioPlayer`.
  public init() {
    self.player = nil
    self.repeatMode = .count()
    self.delay = 0
  }

  /// Plays back audio using the instance's configured attributes,
  /// does nothing if instance is empty.
  ///
  /// You don't call this method directly, instead call the instance as function.
  /// ```swift
  /// let odioPlayer = OdioPlayer("Tap.mp3")
  ///   ...
  /// odioPlayer()
  /// ```
  public func callAsFunction() {
    guard let player = player else { return }
    player.numberOfLoops = repeatMode.numberOfLoops()
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
