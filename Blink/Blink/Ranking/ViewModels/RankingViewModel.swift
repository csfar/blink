//
//  RankingViewModel.swift
//  Blink
//
//  Created by Artur Carneiro on 13/07/20.
//  Copyright © 2020 Artur Carneiro. All rights reserved.
//

import Foundation
import MultipeerConnectivity
import os.log

final class RankingViewModel: NSObject, ObservableObject {

    private let multipeerConnection = Multipeer.shared

    @Published var ideas: [Idea] = [Idea]()

    @Published var topic: String

    init(ideas: [[Idea]],
         topic: String = "") {
        self.topic = topic
        super.init()
        self.ideas = convertIdeasMatrixIntoArray(ideas)
        multipeerConnection.mcSession.delegate = self

        os_log("RankingViewModel initialized as MCSession's delegate.", log: .multipeer, type: .info)

        sendIdeas()
    }

    private func sendIdeas() {
        let mcSession = multipeerConnection.mcSession
        if mcSession.connectedPeers.count > 0 {
            do {
                let data = try JSONEncoder().encode(ideas)
                try mcSession.send(data, toPeers: mcSession.connectedPeers, with: .reliable)
                os_log("Ranking sent to participants", log: .ranking, type: .info)
            } catch _ as EncodingError {
                os_log("Failed to encode ranking", log: .ranking, type: .error)
            } catch {
                os_log("Failed to send ranking", log: .ranking, type: .error)
            }
        }
    }

    private func convertIdeasMatrixIntoArray(_ ideas: [[Idea]]) -> [Idea] {
        var arr: [Idea] = [Idea]()
        for row in ideas {
            arr.append(contentsOf: row)
        }
        return arr.map { if $0.isSelected {
            var idea = $0
            idea.votes += 1
            return idea
        } else {
            return $0
        }}.sorted { $0.votes > $1.votes }
    }

}

extension RankingViewModel: MCSessionDelegate {
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
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
