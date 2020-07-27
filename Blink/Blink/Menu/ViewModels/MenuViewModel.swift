//
//  MenuViewModel.swift
//  Blink
//
//  Created by Edgar Sgroi on 08/07/20.
//  Copyright © 2020 Artur Carneiro. All rights reserved.
//

import Foundation
import MultipeerConnectivity
import os.log

final class MenuViewModel: NSObject, ObservableObject {
    
    private lazy var multipeerConnection = Multipeer.shared

    @Published var topic: String = ""
    
    @Published var timer: Int = 0

    @Published var isHosting: Bool = false

    var anyConnected: Bool {
        if multipeerConnection.mcSession.connectedPeers.count > 0 {
            return true
        } else {
            return false
        }
    }

    override init() {
        super.init()
        startHosting()
        multipeerConnection.mcSession.delegate = self
        
        os_log("MenuViewModel initialized as MCSession's delegate.", log: .multipeer, type: .info)
    }
    /// Starts hosting a Multipeer session with `blnk` as service type.
    func startHosting() {
        multipeerConnection.mcAdvertiserAssistant = MCAdvertiserAssistant(serviceType: "blnk", discoveryInfo: nil, session: multipeerConnection.mcSession)
        multipeerConnection.mcAdvertiserAssistant.start()
        isHosting.toggle()
        os_log("Started hosting a Multipeer session", log: .multipeer, type: .info)
    }
}

// MARK: - MultipeerConnectivity Session Delegate Functions
extension MenuViewModel: MCSessionDelegate {
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        switch state {
        case MCSessionState.connected:
            multipeerConnection.connectionStatus = .connected
        case MCSessionState.connecting:
            multipeerConnection.connectionStatus = .connecting
        case MCSessionState.notConnected:
            multipeerConnection.connectionStatus = .notConnected
        @unknown default:
            multipeerConnection.connectionStatus = .unknown
        }
    }

    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
    }

    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
    }

    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
    }

    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {
    }
}
