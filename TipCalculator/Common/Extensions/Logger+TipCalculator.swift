//
//  Logger+TipCalculator.swift
//  TipCalculator
//
//  Created by Danijel Kecman on 8/13/23.
//

import OSLog

extension Logger {
  /// Using your bundle identifier is a great way to ensure a unique identifier.
  private static var subsystem = Bundle.main.bundleIdentifier!
  
  /// Logs the view cycles like a view that appeared.
  static let viewCycle = Logger(subsystem: subsystem, category: "viewcycle")
  
  /// All logs related to tracking and analytics.
  static let statistics = Logger(subsystem: subsystem, category: "statistics")
}

// Logger.viewCycle.notice("Notice example")
// Logger.viewCycle.info("Info example")
// Logger.viewCycle.debug("Debug example")
// Logger.viewCycle.trace("Notice example")
// Logger.viewCycle.warning("Warning example")
// Logger.viewCycle.error("Error example")
// Logger.viewCycle.fault("Fault example")
// Logger.viewCycle.critical("Critical example")
