//
//  RankingViewModel.swift
//  Blink
//
//  Created by Artur Carneiro on 13/07/20.
//  Copyright © 2020 Artur Carneiro. All rights reserved.
//

import Foundation
import MultipeerConnectivity

final class RankingViewModel: NSObject, ObservableObject {
    typealias Ranking = [(key: String, value: Int)]

    private let multipeerConnection = Multipeer.shared

    @Published var ranking: Ranking

    @Published var topic: String

    init(ranking: Ranking,
         topic: String = "") {
        self.ranking = ranking
        self.topic = topic
        super.init()
//        multipeerConnection.delegate = self
        multipeerConnection.mcSession.delegate = self
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
