//
//  RankingViewModel.swift
//  Blink_iOS
//
//  Created by Victor Falcetta do Nascimento on 15/07/20.
//  Copyright © 2020 Artur Carneiro. All rights reserved.
//

import Foundation
import MultipeerConnectivity
import os.log

final class RankingViewModel: NSObject, ObservableObject {
    
    private let multipeerConnection = Multipeer.shared
    
    @Published var topic: String
    private var ideas: [Idea] = [] {
        didSet {
            ranking = ideas.sorted { $0.votes > $1.votes }
        }
    }
    @Published var ranking: [Idea] = []
    
    init(topic: String = "") {
        self.topic = topic
        super.init()
        multipeerConnection.mcSession.delegate = self
    }

}

extension RankingViewModel: MCSessionDelegate {
    
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
        do {
            let receivedIdeas = try JSONDecoder().decode([Idea].self, from: data)
            self.ideas = receivedIdeas
        } catch {
            os_log("Could not receive ranking data from Host.", log: OSLog.ranking, type: .error)
        }
    }
    
    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        
    }
    
    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
        
    }
    
    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {
        
    }
    
    
}
