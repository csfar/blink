//
//  OSLog+Extensions.swift
//  Blink
//
//  Created by Artur Carneiro on 16/07/20.
//  Copyright © 2020 Artur Carneiro. All rights reserved.
//

import Foundation
import os.log

extension OSLog {
    private static var subsystem = Bundle.main.bundleIdentifier ?? "com.edsgroi.Blink.error"

    static let brainstorm = OSLog(subsystem: subsystem, category: "brainstorm")
    static let voting = OSLog(subsystem: subsystem, category: "voting")
    static let ranking = OSLog(subsystem: subsystem, category: "ranking")
    static let interaction = OSLog(subsystem: subsystem, category: "interaction")
    static let multipeer = OSLog(subsystem: subsystem, category: "multipeer")
}

