//
//  BrainstormingViewModel.swift
//  Blink_iOS
//
//  Created by Edgar Sgroi on 08/07/20.
//  Copyright © 2020 Artur Carneiro. All rights reserved.
//

import Foundation
import MultipeerConnectivity
import os.log

final class BrainstormingViewModel: NSObject, ObservableObject {
    
    private let multipeerConnection = Multipeer.shared
    @Published var topic: String = ""

    @Published var ideas: [Idea] = [Idea]()
    @Published var shouldVote: Bool = false
    private var shouldDelegate: Bool?
    
    override init() {
        super.init()
        if let _ = shouldDelegate {
            os_log("BrainstormingViewModel initialized.", log: .multipeer, type: .info)
        } else {
            multipeerConnection.mcSession.delegate = self
            os_log("BrainstormingViewModel initialized as MCSession's delegate.", log: .multipeer, type: .info)
        }

    }
    
    func sendIdea(_ content: String) {
        let idea = Idea(content: content)
        let mcSession = multipeerConnection.mcSession
        if mcSession.connectedPeers.count > 0 {
            do {
                let data = try JSONEncoder().encode(idea)
                try mcSession.send(data, toPeers: mcSession.connectedPeers, with: .reliable)
                os_log("Idea sent to mediator", log: .brainstorm, type: .info)
            } catch _ as EncodingError {
                os_log("Failed to encode idea as JSON.", log: OSLog.brainstorm, type: .error)
            } catch _ as NSError {
                os_log("Failed to send data to mediator.", log: OSLog.brainstorm, type: .error)
            }
        }
    }
}
extension BrainstormingViewModel: MCSessionDelegate {
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
        DispatchQueue.main.async {
            do {
                let ideas = try JSONDecoder().decode([Idea].self, from: data)
                self.ideas = ideas
                self.shouldVote = true
                self.shouldDelegate = false
                os_log("Ideas received. Moving on to voting.", log: .brainstorm, type: .info)
            } catch {
                os_log("Failed to decode ideas from Mediator to be voted on", log: .voting, type: .error)
            }
        }
    }
    
    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        
    }
    
    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
        
    }
    
    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {
        
    }
    
    
}
