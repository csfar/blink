//
//  OSLog+Extensions.swift
//  Blink_iOS
//
//  Created by Victor Falcetta do Nascimento on 15/07/20.
//  Copyright © 2020 Artur Carneiro. All rights reserved.
//

import Foundation
import os.log

extension OSLog {
    private static var subsystem = Bundle.main.bundleIdentifier ?? "com.csfar.Blink.error"
    static let brainstorm = OSLog(subsystem: subsystem, category: "brainstorm")
    static let voting = OSLog(subsystem: subsystem, category: "voting")
    static let ranking = OSLog(subsystem: subsystem, category: "ranking")
}
