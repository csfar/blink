//
//  VotingViewModel.swift
//  Blink_iOS
//
//  Created by Edgar Sgroi on 09/07/20.
//  Copyright © 2020 Artur Carneiro. All rights reserved.
//

import Foundation
import MultipeerConnectivity
import os.log

final class VotingViewModel: NSObject, ObservableObject {
    
    private var multipeerConnection = Multipeer.shared
    
    @Published var topic: String
    @Published var ideas: [Idea]
    
    init(ideas: [Idea],
         topic: String = "") {
        self.ideas = ideas
        self.topic = topic
        super.init()
        multipeerConnection.mcSession.delegate = self
    }
    
    func checkVotedIdeas(_ ideas: [Idea]) {
        let votedIdeas = ideas.filter { $0.isSelected == true }
        sendVotes(votedIdeas)
    }
    
    /// - TODO: Check any necessary changes on p2p for new data structure.
    private func sendVotes(_ votes: [Idea]) {
        let mcSession = multipeerConnection.mcSession
        if mcSession.connectedPeers.count > 0 {
            do {
                let data = try JSONEncoder().encode(votes)
                try mcSession.send(data, toPeers: mcSession.connectedPeers, with: .reliable)
            } catch _ as EncodingError {
                os_log("Failed to encode voted ideas as JSON.", log: OSLog.voting, type: .error)
            } catch _ as NSError {
                os_log("Failed to send data through connected peers.", log: OSLog.voting, type: .error)
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
    
    /// - TODO: Check any necessary changes on p2p for new data structure.
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        do {
            let receivedIdeas = try JSONDecoder().decode([Idea].self, from: data)
            ideas = receivedIdeas
        } catch {
            os_log("Failed to decode ideas data from Host.", log: OSLog.voting, type: .error)
        }
    }
    
    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
    }
    
    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
    }
    
    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {
    }
    
    
}
