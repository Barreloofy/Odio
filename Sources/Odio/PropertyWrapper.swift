//
// PropertyWrapper.swift
// Odio
//
// Created by Barreloofy on 7/24/25 at 11:04 PM
//

import SwiftUI

/// A property wrapper that can playback audio.
///
/// > Important:
/// The underlying player is managed as a `@State` property wrapper.
/// As a result, rapid or successive calls to the `OdioPlayer` instance may not play audio if a previous playback is still active.
/// This is particularly noticeable with lengthy audio files or quick successive calls.
/// If this becomes a concern, call the `end()` method before initiating a new playback.
///
/// Use the `FileKey` overload initializer to quickly and safely initialize a new `@AudioPlayer`.
/// ```swift
/// extension FileKey {
///   static let tap = FileKey(value: "TapSound.mp3")
/// }
///   ...
/// @AudioPlayer(.tap) private var audioPlayer
/// ```
///
/// You can also initialize an empty `@AudioPlayer`, useful when the audio file to use is not known initially.
/// ```swift
/// @AudioPlayer private var audioPlayer
///
/// let name: String
///
/// func body(content: Content) -> some View {
///   content
///     .simultaneousGesture(
///       TapGesture()
///         .onEnded { audioPlayer() })
///         .onAppear { audioPlayer = OdioPlayer(name) }
///         .onDisappear { audioPlayer.stop() }
/// }
/// ```
///
/// Initialize an instance of `@AudioPlayer`with playback delay.
/// Here, playback will occur after a delay of one second.
/// ```swift
/// @AudioPlayer(.tap, after: 1.0) private var audioPlayer
///
/// var body: some View {
///   Button("Tap Me") { audioPlayer() }
/// }
/// ```
///
/// Refer directly to an instance of `@AudioPlayer` to implicitly access its wrapped value.
/// ```swift
/// @AudioPlayer("TapSound.mp3") private var audioPlayer
///
/// var body: some View {
///   Button("Play Sound") { audioPlayer() }
///
///   Button("New Sound") { audioPlayer = .init("ThunderSound.mp3") }
/// }
/// ```
@MainActor
@propertyWrapper
public struct AudioPlayer: DynamicProperty {
  /// The underlying `@State<OdioPlayer>` instance.
  @State private var player: OdioPlayer

  /// The underlying value referenced by the `@AudioPlayer` instance.
  ///
  /// You don't typically access `wrappedValue` explicitly.
  /// Instead, you gain access to the wrapped value by referring to the instance
  /// that you create with `@AudioPlayer`.
  public var wrappedValue: OdioPlayer {
    get { player }
    nonmutating set { player = newValue }
  }

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
      self.player = .init(
        name,
        after: delay,
        repeatMode: repeatMode,
        from: bundle)
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
      self.player = .init(
        key,
        after: delay,
        repeatMode: repeatMode,
        from: bundle)
    }

  /// Creates an empty `@AudioPlayer`.
  public init() { player = .init() }
}
