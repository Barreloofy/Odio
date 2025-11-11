//
// FileKey.swift
// Odio
//
// Created by Barreloofy on 8/8/25 at 4:10 PM
//

/// A type representing audio files as properties of itself.
/// Extend `FileKey` with the `@Entry` macro for safer and quicker access.
///
/// Create `FileKey` entries by extending the `FileKey` structure
/// with new properties and attaching the @Entry macro to the variable declarations:
/// ```swift
/// extension FileKey {
///   @Entry var tap = "TapSound.mp3"
/// }
/// ```
///
/// Use the `KeyPath` syntax where `FileKey` is supported:
/// ```swift
/// ...
/// @AudioPlayer(\.tap) private var audioPlayer
/// ...
/// ```
public struct FileKey {}
