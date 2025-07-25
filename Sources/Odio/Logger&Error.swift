//
// Logger.swift
// Odio
//
// Created by Barreloofy on 7/24/25 at 6:23 PM
//

import os

enum OdioError: Error {
  case resourceNotFound(String)
}

let errorLogger = Logger(subsystem: "Odio", category: "Error")
