//
//  VotingViewModel.swift
//  Blink_iOS
//
//  Created by Edgar Sgroi on 09/07/20.
//  Copyright © 2020 Artur Carneiro. All rights reserved.
//

import Foundation
import MultipeerConnectivity

class VotingViewModel: NSObject {
    
    var multipeerConnection = Multipeer.shared
    
    var ideas: [String] = []
    var votes: [String] = []
    
    override init() {
        super.init()
        multipeerConnection.delegate = self
    }
    
    func sendVotes() {
        let mcSession = multipeerConnection.mcSession
        if mcSession.connectedPeers.count > 0 {
            if let votesData = try? NSKeyedArchiver.archivedData(withRootObject: votes, requiringSecureCoding: false) {
                do {
                    try mcSession.send(votesData, toPeers: mcSession.connectedPeers, with: .reliable)
                } catch let error as NSError {
                    let ac = UIAlertController(title: "Send error", message: error.localizedDescription, preferredStyle: .alert)
                    ac.addAction(UIAlertAction(title: "Ok", style: .default))
//                    present(ac, animated: true)
                }
            }
        }
    }
}

extension VotingViewModel: MCSessionDelegate {
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
        if let ideasList:[String] = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [String] {
            ideas = ideasList
        }
    }
    
    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
    }
    
    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
    }
    
    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {
    }
    
    
}