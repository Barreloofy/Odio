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

  /// The speed at which playback occurs.
  public var speed: Float

  /// The delay before playback occurs.
  public var delay: TimeInterval

  /// The playback repeat mode.
  public var repeatMode: RepeatMode

  /// - Parameters:
  ///   - fileName: The name of an audio file.
  ///   - speed: The speed at which playback occurs.
  ///   - delay: The time in seconds before playback occurs.
  ///   - repeatMode: The playback repeat mode to use.
  ///   - bundle: The bundle to retrieve the file from.
  public init(
    for fileName: String,
    at speed: Float = 1,
    after delay: TimeInterval = 0,
    repeatMode: RepeatMode = .never,
    from bundle: Bundle = .main) {
      self.player = createPlayer(name: fileName, bundle: bundle)
      self.speed = speed
      self.delay = delay
      self.repeatMode = repeatMode
    }

  /// - Parameters:
  ///   - keyPath: A key path to a specific resulting value representing an audio file.
  ///   - speed: The speed at which playback occurs.
  ///   - delay: The time in seconds before playback occurs.
  ///   - repeatMode: The playback repeat mode to use.
  ///   - bundle: The bundle to retrieve the file from.
  public init(
    from keyPath: KeyPath<FileKey, String>,
    at speed: Float = 1,
    after delay: TimeInterval = 0,
    repeatMode: RepeatMode = .never,
    from bundle: Bundle = .main) {
      self.player = createPlayer(name: FileKey()[keyPath: keyPath], bundle: bundle)
      self.speed = speed
      self.delay = delay
      self.repeatMode = repeatMode
    }

  /// Creates an empty `OdioPlayer` instance.
  public init() {
    self.player = nil
    self.speed = 1
    self.delay = 0
    self.repeatMode = .never
  }

  /// Starts playback, if the player was previously stoped, resumes playback
  /// otherwise starts a new playback. If player is empty does nothing.
  ///
  /// You don't call this method directly, instead call the instance as a function.
  /// ```swift
  /// let odioPlayer = OdioPlayer("TapSound.mp3")
  ///   ...
  /// odioPlayer()
  /// ```
  public func callAsFunction() {
    guard let player = player else { return }

    player.enableRate = speed == 1 ? false : true
    player.rate = speed
    player.numberOfLoops = repeatMode.numberOfLoops()
    player.play(atTime: player.deviceCurrentTime + delay)
  }

  /// Stops playback, to resume call the player as you would normally.
  public func stop() {
    player?.pause()
  }

  /// Ends playback, calling the player afterwards starts a new playback.
  public func end() {
    player?.stop()
    player?.currentTime = .zero
  }
}
