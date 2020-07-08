//
//  Multipeer.swift
//  Blink
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

class Multipeer: NSObject {
    
    static let shared = Multipeer()
    
    var peerID: MCPeerID
    var mcSession: MCSession
    var mcAdvertiserAssistant: MCAdvertiserAssistant
    
    var connectionStatus: ConnectionStatus
    var delegate: MCSessionDelegate?

    override init() {
        peerID = MCPeerID(displayName: UIDevice.current.name)
        mcSession = MCSession(peer: peerID, securityIdentity: nil, encryptionPreference: .required)
        connectionStatus = .notConnected
        mcAdvertiserAssistant = MCAdvertiserAssistant(serviceType: "blink-kb", discoveryInfo: nil, session: mcSession)
        super.init()
        
    }
}
