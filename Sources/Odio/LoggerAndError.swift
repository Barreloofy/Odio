//
// Logger.swift
// Odio
//
// Created by Barreloofy on 7/24/25 at 6:23 PM
//

import Foundation
import os

struct OdioError: LocalizedError {
  let message: String

  var errorDescription: String { message }
}

let errorLogger = Logger(subsystem: "Odio", category: "Error")
