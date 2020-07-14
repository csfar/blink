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
    @Published private(set) var ideasMatrix: [[String]]

    /// The topic set for the session.
    @Published private(set) var topic: String

    /// The timer set for the session.
    @Published private(set) var timer: String
    
    /// String array variable to store ideas.
    /// When an idea is sent through P2P connection,
    /// It will be stored in this array.
    var ideas: [String]

    init(ideas: [[String]] = [[String]](),
         topic: String = "",
         timer: String = "") {
        self.ideas = []
        self.ideasMatrix = ideas
        self.topic = topic
        self.timer = timer
        super.init()
        multipeerConnection.delegate = self
    }
    
    /// Internal functional that converts the idea String array
    /// in an idea 2D String matrix with 3 columns and N rows.
    /// This function is called with the following parameters:
    /// - Parameter ideas: The String array that contains the ideas sent through P2P connection.
    func convertIdeasArrayInMatrix(ideas: [String]) -> [[String]] {
        var matrixIdeas: [[String]] = []
        var colIndex: Int = 0
        var ideaArray: [String] = []
        for idea in ideas {
            if colIndex == 3 {
                matrixIdeas.append(ideaArray)
                ideaArray = []
                colIndex = 0
                
                if ideaArray.isEmpty {
                    ideaArray.append(idea)
                    colIndex += 1
                }
                
            } else {
                ideaArray.append(idea)
                colIndex += 1
            }
        }
        if ideaArray.isEmpty == false {
            matrixIdeas.append(ideaArray)
        }
        return matrixIdeas
    }
}

extension BrainstormingViewModel: MCSessionDelegate {
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        switch state {
        case MCSessionState.connected:
            multipeerConnection.connectionStatus = .connected
            print("1")
        case MCSessionState.connecting:
            multipeerConnection.connectionStatus = .connecting
            print("2")
        case MCSessionState.notConnected:
            multipeerConnection.connectionStatus = .notConnected
            print("3")
        @unknown default:
            multipeerConnection.connectionStatus = .unknown
            print("4")
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
