//
//  MenuViewModel.swift
//  Blink_iOS
//
//  Created by Edgar Sgroi on 08/07/20.
//  Copyright © 2020 Artur Carneiro. All rights reserved.
//

import Foundation
import MultipeerConnectivity
import os.log

final class MenuViewModel: NSObject, ObservableObject {
    
    //TODO - Pesquisar como usar o Browser no SwiftUI
    
    let multipeerConnection = Multipeer.shared

    @Published var isConnected: Bool = false
    @Published var isJoining: Bool = false
    
    typealias MCBrowserViewControllerType = MCBrowserViewController
    
    override init() {
        super.init()
        multipeerConnection.delegate = self
    }

}

extension MenuViewModel: MCSessionDelegate {
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
    }
    
    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
    }
    
    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
    }
    
    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {
    }
}

extension MenuViewModel:  MCBrowserViewControllerDelegate {
    func browserViewControllerDidFinish(_ browserViewController: MCBrowserViewController) {
        browserViewController.dismiss(animated: true) { [weak self] in
            self?.isConnected.toggle()
        }
    }
    
    func browserViewControllerWasCancelled(_ browserViewController: MCBrowserViewController) {
        browserViewController.dismiss(animated: true) { [weak self] in
            self?.isConnected.toggle()
        }
    }
    
    
}
