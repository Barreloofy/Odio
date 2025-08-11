//
// FileKey.swift
// Odio
//
// Created by Barreloofy on 8/8/25 at 4:10 PM
//

/// A type representing a file.
///
/// Extend `FileKey` with a static instance for safer and quicker access.
/// ```swift
/// extension FileKey {
///   static let tapSound = FileKey(value: "TapSound.mp3")
/// }
/// ```
public struct FileKey: Sendable {
  public let value: String

  /// - Parameters:
  ///   - value: The name of a file with its filename extension.
  public init(value: String) {
    self.value = value
  }

  public func callAsFunction() -> String {
    value
  }
}
