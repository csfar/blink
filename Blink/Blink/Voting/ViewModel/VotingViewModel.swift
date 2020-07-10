//
//  VotingViewModel.swift
//  Blink
//
//  Created by Edgar Sgroi on 08/07/20.
//  Copyright © 2020 Artur Carneiro. All rights reserved.
//

import Foundation
import MultipeerConnectivity

class VotingViewModel: NSObject {
    
    typealias Ranking = [(key: String, value: Int)]
    let multipeerConnection = Multipeer.shared
    
    private var ideas: [String]
    private var votes: [String]
    var rank: Ranking
    
    /// Initialization of this ViewModel with the following parameters:
    /// - Parameter ideas: An array of String type that composes the ideas
    init(ideas: [String]) {
        self.ideas = ideas
        votes = []
        rank = []
        
        super.init()
        multipeerConnection.delegate = self
        sendIdeas()
        
    }
    
    func receiveTvVotes(_ tvVotes: [String]) {
        votes.append(contentsOf: tvVotes)
    }
    
    func sendIdeas() {
        let mcSession = multipeerConnection.mcSession
        if mcSession.connectedPeers.count > 0 {
            if let ideasData = try? NSKeyedArchiver.archivedData(withRootObject: ideas, requiringSecureCoding: false) {
                do {
                    try mcSession.send(ideasData, toPeers: mcSession.connectedPeers, with: .reliable)
                } catch let error as NSError {
                    let ac = UIAlertController(title: "Send error", message: error.localizedDescription, preferredStyle: .alert)
                    ac.addAction(UIAlertAction(title: "Ok", style: .default))
                    /// - TODO: Propper error handling
//                    present(ac, animated: true)
                }
            }
        }
    }
    
    func countVotes(votes: [String], ideas: [String]) -> Ranking {
        let votedIdeas = Array(Set(votes))
        var nonVotedIdeas = [String]()
        for i in ideas {
            if !votedIdeas.contains(i) {
                nonVotedIdeas.append(i)
            }
        }
        let votedIdeasArray = votes.map { ($0, 1) }
        let ideasFrequency = Dictionary(votedIdeasArray, uniquingKeysWith: +)
        let nonVotedIdeasArray = nonVotedIdeas.map { ($0, 0) }
        let ideasNonFrequency = Dictionary(nonVotedIdeasArray, uniquingKeysWith: +)
        let votingResult = ideasFrequency.merging(ideasNonFrequency) { (_, new) in new }
        return votingResult.sorted(by: {($0.value > $1.value)})
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
        if let votesList:[String] = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [String] {
            votes += votesList        }
    }

    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
    }

    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
    }

    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {
    }
}
