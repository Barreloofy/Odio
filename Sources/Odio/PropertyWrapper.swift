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
/// The underlying player is stored as a `@State` property wrapper,
/// which has the side effect of not all calls to the `@AudioPlayer` instance will play audio,
/// only once the previous call has finished playing.
/// Most notably, it is with calls made in quick succession or lengthy audio.
/// To resolve the issue call the `end()` method before the next call.
///
/// Use the `FileKey` overload initializer to quickly and safely initialize a new `@AudioPlayer`.
///```swift
/// extension FileKey {
///   static let tapSound = FileKey(value: "TapSound.mp3")
/// }
///
/// @AudioPlayer(.tapSound) private var audioPlayer
///```
///
/// You can also initialize an empty `@AudioPlayer`, useful when the audio file to use is not known initially.
/// ```swift
/// struct SoundOnTap: ViewModifier {
///   @AudioPlayer private var audioPlayer
///
///   let name: String
///
///   func body(content: Content) -> some View {
///     content
///       .simultaneousGesture(
///         TapGesture()
///           .onEnded { audioPlayer() })
///       .onAppear { audioPlayer = OdioPlayer(name) }
///       .onDisappear { audioPlayer.stop() }
///   }
/// }
/// ```
///
///Initialize an instance of `@AudioPlayer` with the `after` argument label specified to introduce a delay before playback.
///```swift
/// struct DelayView: View {
///   @AudioPlayer(.tap, after: 1.0) private var audioPlayer
///
///   var body: some View {
///     Button("Tap Me") { audioPlayer() }
///   }
/// }
///```
///
/// Refer directly to an instance of `@AudioPlayer` to access its wrapped value.
/// ```swift
/// struct SoundView: View {
///   @AudioPlayer("TapSound.mp3") private var audioPlayer
///
///   var body: some View {
///       Button("Play Sound") { audioPlayer() }
///
///       Button("New Sound") { audioPlayer = .init("ThunderSound.mp3") }
///   }
/// }
/// ```
@MainActor
@propertyWrapper public struct AudioPlayer: DynamicProperty {
  @State private var player: OdioPlayer

  public var wrappedValue: OdioPlayer {
    get { player }
    nonmutating set { player = newValue }
  }

  /// - Parameters:
  ///   - name: The name of an audio file.
  ///   - delay: The time in seconds before playback occurs.
  ///   - bundle: The bundle to retrieve the file from.
  public init(_ name: String, after delay: TimeInterval = 0, from bundle: Bundle = .main) {
    self.player = .init(name, after: delay, from: bundle)
  }

  /// - Parameters:
  ///   - key: The key identifying an audio file.
  ///   - delay: The time in seconds before playback occurs.
  ///   - bundle: The bundle to retrieve the file from.
  public init(_ key: FileKey, after delay: TimeInterval = 0, from bundle: Bundle = .main) {
    self.player = .init(key(), after: delay, from: bundle)
  }

  public init() { player = .init() }
}
