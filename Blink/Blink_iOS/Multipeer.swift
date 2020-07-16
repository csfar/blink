//
//  Multipeer.swift
//  Blink_iOS
//
//  Created by Edgar Sgroi on 08/07/20.
//  Copyright © 2020 Artur Carneiro. All rights reserved.
//

import Foundation
import MultipeerConnectivity

enum ConnectionStatus {
    case connected
    case connecting
    case notConnected
    case unknown
}

final class Multipeer: NSObject {
    
    static let shared = Multipeer()
    
    private(set) var peerID: MCPeerID
    private(set) var mcSession: MCSession
    var mcAdvertiserAssistant: MCAdvertiserAssistant
    
    var connectionStatus: ConnectionStatus
    var delegate: MCSessionDelegate?

    override init() {
        peerID = MCPeerID(displayName: UIDevice.current.name)
        mcSession = MCSession(peer: peerID, securityIdentity: nil, encryptionPreference: .required)
        connectionStatus = .notConnected
        mcAdvertiserAssistant = MCAdvertiserAssistant(serviceType: "blnk", discoveryInfo: nil, session: mcSession)
        super.init()
    }
}
