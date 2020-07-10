//
//  BrainstormingViewModel.swift
//  Blink
//
//  Created by Edgar Sgroi on 08/07/20.
//  Copyright © 2020 Artur Carneiro. All rights reserved.
//

import Foundation
import MultipeerConnectivity


class BrainstormingViewModel: NSObject, ObservableObject {
    
    /// Shared instance of the Multipeer Class.
    let multipeerConnection = Multipeer.shared
    
    /// Published variable of the idea Matrix.
    /// Any changes that occur in this variable will make the view update.
    @Published var ideasMatrix: [[String]] = [[String]]()
    
    /// String array variable to store ideas.
    /// When an idea is sent through P2P connection,
    /// It will be stored in this array.
    var ideas: [String]
    
    /// Initialization of the Brainstorm ViewModel.
    override init() {
        ideas = []
        super.init()
        multipeerConnection.delegate = self
    }
    
    /// Internal functional that converts the idea String array
    /// in an idea 2D String matrix with 3 columns and N rows.
    /// This function is called with the following parameters:
    /// - Parameter ideas: The String array that contains the ideas sent through P2P connection.
    func convertIdeasArrayInMatrix(ideas: [String]) -> [[String]] {
        var matrixIdeas: [[String]] = [[String]]()
        var colIndex: Int = 0
        var rowIndex: Int = 0
        for idea in ideas {
            if colIndex == 3 {
                colIndex = 0
            }
            matrixIdeas[rowIndex].append(idea)
            rowIndex += 1
            colIndex += 1
        }
        return matrixIdeas
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
        if let text = String(data: data, encoding: .utf8) {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                if !self.ideas.contains(text) {
                    self.ideas.append(text)
                    self.ideasMatrix = self.convertIdeasArrayInMatrix(ideas: self.ideas)
                }
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
