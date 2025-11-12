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
/// Use the `FileKey` initializer to quickly and safely initialize a new `@AudioPlayer`:
/// ```swift
/// extension FileKey {
///   @Entry var tap = "TapSound.mp3"
/// }
///   ...
/// @AudioPlayer(\.tap) private var audioPlayer
/// ```
///
/// You can also initialize an empty `@AudioPlayer`, useful when the audio file to use is not known initially,
/// for example, here is an excerpt from one of the `audioFeedback` methods implementation:
/// ```swift
/// @AudioPlayer private var audioPlayer
///
/// let name: String
/// let delay: TimeInterval
///
/// func body(content: Content) -> some View {
///   content
///     .simultaneousGesture(
///       TapGesture()
///         .onEnded { audioPlayer() })
///     .onAppear { audioPlayer = OdioPlayer(for: name, after: delay) }
///     .onDisappear { audioPlayer.end() }
/// }
/// ```
///
/// Initialize an instance of `@AudioPlayer`with playback delay,
/// here, playback will occur after a delay of one second:
/// ```swift
/// @AudioPlayer(\.tap, after: 1.0) private var audioPlayer
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
  ///   - fileName: The name of an audio file.
  ///   - delay: The time in seconds before playback occurs.
  ///   - repeatMode: The playback repeat mode to use.
  ///   - bundle: The bundle to retrieve the file from.
  public init(
    _ fileName: String,
    after delay: TimeInterval = 0,
    repeatMode: RepeatMode = .count(),
    from bundle: Bundle = .main) {
      self.player = .init(
        for: fileName,
        after: delay,
        repeatMode: repeatMode,
        from: bundle)
    }

  /// - Parameters:
  ///   - keyPath: A key path to a specific resulting value representing an audio file.
  ///   - delay: The time in seconds before playback occurs.
  ///   - repeatMode: The playback repeat mode to use.
  ///   - bundle: The bundle to retrieve the file from.
  public init(
    _ keyPath: KeyPath<FileKey, String>,
    after delay: TimeInterval = 0,
    repeatMode: RepeatMode = .count(),
    from bundle: Bundle = .main) {
      self.player = .init(
        from: keyPath,
        after: delay,
        repeatMode: repeatMode,
        from: bundle)
    }

  /// Creates an empty `@AudioPlayer` instance.
  public init() { player = .init() }
}
