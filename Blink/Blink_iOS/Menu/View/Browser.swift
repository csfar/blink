//
//  Browser.swift
//  Blink_iOS
//
//  Created by Edgar Sgroi on 13/07/20.
//  Copyright © 2020 Artur Carneiro. All rights reserved.
//

import Foundation
import MultipeerConnectivity
import SwiftUI


struct Browser: UIViewControllerRepresentable {
    var delegate: MenuViewModel

    func makeUIViewController(context: Context) -> MCBrowserViewController {
        let mcBrowser = MCBrowserViewController(serviceType: "blnk", session: Multipeer.shared.mcSession)
        mcBrowser.delegate = self.delegate
        return mcBrowser
    }
    
    func updateUIViewController(_ uiViewController: MCBrowserViewController, context: Context) {
    }
    
    typealias UIViewControllerType = MCBrowserViewController
}
