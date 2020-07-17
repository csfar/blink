//
//  VotingViewModel.swift
//  Blink
//
//  Created by Edgar Sgroi on 08/07/20.
//  Copyright © 2020 Artur Carneiro. All rights reserved.
//

import Foundation
import MultipeerConnectivity
import os.log


/// `VotingView`'s ViewModel dependant on `MultipeerConnectivity`.
class VotingViewModel: NSObject, ObservableObject {
    /// Shared instace of the Multipeer Singleton.
    private let multipeerConnection = Multipeer.shared

    /// Published variable of the idea Matrix.
    /// Any changes that occur in this variable will make the view update.
    @Published var ideas: [[Idea]] = [[Idea]]()

    /// The poll of votes for the session.
    @Published var votes: [Idea] = [Idea]()

    private var arrIdeas: [Idea] = [Idea]()

    /// The topic set for the session.
    var topic: String
    
    /// Initialization of this ViewModel with the following parameters:
    /// - Parameter ideas: An array of String type that composes the ideas
    /// - Parameter topic: A session's topic. Empty by default.
    init(ideas: [[Idea]],
         topic: String = "") {
        self.ideas = ideas
        self.topic = topic
        super.init()
        multipeerConnection.mcSession.delegate = self
        sendIdeas()
    }

    /// Sends ideas generated during the Brainstorming session to
    /// all iOS users connected to the current session.
    private func sendIdeas() {
        let mcSession = multipeerConnection.mcSession
        if mcSession.connectedPeers.count > 0 {
            if let ideasData = try? NSKeyedArchiver.archivedData(withRootObject: ideas, requiringSecureCoding: false) {
                do {
                    try mcSession.send(ideasData, toPeers: mcSession.connectedPeers, with: .reliable)
                } catch {
                    /// - TODO: Propper error handling
                }
            }
        }
    }

    func addNew(idea: Idea) {
        arrIdeas.append(idea)
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.ideas = self.convertIdeasArrayInMatrix(ideas: self.arrIdeas)
        }
    }

    /// Internal functional that converts the idea String array
    /// in an idea 2D String matrix with 3 columns and N rows.
    /// This function is called with the following parameters:
    /// - Parameter ideas: The String array that contains the ideas sent through P2P connection.
    func convertIdeasArrayInMatrix(ideas: [Idea]) -> [[Idea]] {
        var matrixIdeas: [[Idea]] = []
        var colIndex: Int = 0
        var ideaArray: [Idea] = []
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

// MARK: - MultipeerConnectivity Session Delegate Functions
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
        do {
            let idea = try JSONDecoder().decode(Idea.self, from: data)
            addNew(idea: idea)
        } catch {
            os_log("Failed to decode Idea from iOS participant", log: .brainstorm, type: .error)
        }
    }

    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
    }

    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
    }

    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {
    }
}
