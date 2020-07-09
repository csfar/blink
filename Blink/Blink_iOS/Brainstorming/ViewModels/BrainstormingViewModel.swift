//
//  BrainstormingViewModel.swift
//  Blink_iOS
//
//  Created by Edgar Sgroi on 08/07/20.
//  Copyright © 2020 Artur Carneiro. All rights reserved.
//

import Foundation
import MultipeerConnectivity

class BrainstormingViewModel: NSObject {
    
    let multipeerConnection = Multipeer.shared
    
    override init() {
        super.init()
    }
    
    func sendIdea(idea: String) {
        let mcSession = multipeerConnection.mcSession
        if mcSession.connectedPeers.count > 0 {
            if let ideaData = idea.data(using: .utf8) {
                do {
                    try mcSession.send(ideaData, toPeers: mcSession.connectedPeers, with: .reliable)
                } catch let error as NSError {
                    let ac = UIAlertController(title: "Send error", message: error.localizedDescription, preferredStyle: .alert)
                    ac.addAction(UIAlertAction(title: "Ok", style: .default))
//                    present(ac, animated: true)
                }
            }
        }
    }
}
