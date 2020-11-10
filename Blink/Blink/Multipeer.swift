//
//  Multipeer.swift
//  Blink
//
//  Created by Edgar Sgroi on 08/07/20.
//  Copyright © 2020 Artur Carneiro. All rights reserved.
//

import Foundation
import MultipeerConnectivity
import Combine
import os.log

/// Representation of a `MulipeerConnectivity` session status.
enum ConnectionStatus {
    case connected
    case connecting
    case notConnected
    case unknown
}

/// Singleton responsible for managing a `MultipeerConnectivity` session.
final class Multipeer: NSObject, ObservableObject {
    
    static let shared = Multipeer()
    
    var peerID: MCPeerID
    var mcSession: MCSession
    var mcAdvertiserAssistant: MCAdvertiserAssistant
    
    var connectionStatus: ConnectionStatus
    @Published var connectedPeersName: [String] = []

    override init() {
        peerID = MCPeerID(displayName: "Brainstorm Host \(UIDevice.current.name)")
        mcSession = MCSession(peer: peerID, securityIdentity: nil, encryptionPreference: .required)
        connectionStatus = .notConnected
        mcAdvertiserAssistant = MCAdvertiserAssistant(serviceType: "blnk", discoveryInfo: nil, session: mcSession)
        super.init()
    }
}

extension MCSession {
    
    var peersName: [String] {
        connectedPeers.map({$0.displayName})
    }
}
