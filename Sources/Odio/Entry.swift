//
// File.swift
// Odio
//
// Created by Barreloofy on 11/11/25 at 1:15 PM
//

/// Creates a `FileKey` entry.
///
/// Create `FileKey` entries by extending the `FileKey` structure
/// with new properties and attaching the @Entry macro to the variable declarations:
/// ```swift
/// extension FileKey {
///   @Entry var tap = "TapSound.mp3"
/// }
/// ```
@attached(accessor)
public macro Entry() = #externalMacro(module: "EntryMacros", type: "EntryMacro")
