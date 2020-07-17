//
//  BrainstormingViewModel.swift
//  Blink
//
//  Created by Edgar Sgroi on 08/07/20.
//  Copyright © 2020 Artur Carneiro. All rights reserved.
//

import Foundation
import MultipeerConnectivity
import os.log

/// `BrainstormingView`'s ViewModel dependant on `MultipeerConnectivity`.
class BrainstormingViewModel: NSObject, ObservableObject {
    
    /// Shared instance of the Multipeer Singleton.
    private let multipeerConnection = Multipeer.shared
    
    /// Published variable of the idea Matrix.
    /// Any changes that occur in this variable will make the view update.
    @Published var ideasMatrix: [[Idea]] = [[Idea]]()

    /// The topic set for the session.
    @Published private(set) var topic: String

    /// The timer set for the session.
    @Published private(set) var timer: String = ""

    var brainstormTimer = Timer()

    @Published var isTimerActive: Bool = true
    
    /// String array variable to store ideas.
    /// When an idea is sent through P2P connection,
    /// It will be stored in this array.
    private var ideas: [Idea] = [Idea]()

    /// Initialize a new instance of this type.
    /// Sets itself as the MultipeerConnectivity delegate.
    /// - Parameter ideas: An array of Strings containing the ideas of
    /// a brainstorming session. Empty by default.
    /// - Parameter topic: A session's topic. Empty by default.
    /// - Parameter timer: A session's timer. Empty by default.
    init(topic: String = "",
         timer: Int = 0) {
        self.topic = topic
        super.init()
        self.startBrainstormTimer(counter: timer)
        multipeerConnection.mcSession.delegate = self
    }

    func addIdea(_ content: String) {
        let newIdea = Idea(content: content)
        ideas.append(newIdea)
        ideasMatrix = convertIdeasArrayInMatrix(ideas: ideas)
    }

    func addNew(idea: Idea) {
        ideas.append(idea)
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.ideasMatrix = self.convertIdeasArrayInMatrix(ideas: self.ideas)
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
    
    /// Internal function that creates a
    /// scheduled timer for the Brainstorm View.
    /// This function is called with the following parameters:
    /// - Parameter counter: An Int type variable that tells the time amount for the Brainstorm Timer.
    func startBrainstormTimer(counter: Int) {
        
        /// Create a var to put the counter variable in the function scope.
        var timerCounter = 1 * 60 
        var minute: Int = 0
        var second: Int = 0
        
        /// Instanciating the brainstormTimer as a repeatable scheduledTimer with a 1 second interval.
        brainstormTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { [weak self] (_) in
            
            /// Safely unwrapping the self in the timer scope
            guard let self = self else { return }
            
            /// Updating the timerCounter by decreasing it, and also updating the ViewModel timer String.
            timerCounter = timerCounter - 1
            minute = timerCounter / 60
            second = timerCounter % 60
            
            /// The timer will use 2 in both minute and second display.
            /// If one of them are under 10, a 0 will be added to keep the standard size.
            if minute < 10 {
                if second < 10 {
                    self.timer = "0\(minute) : 0\(second)"
                } else {
                    self.timer = "0\(minute) : \(second)"
                }
            } else {
                if second < 10 {
                    self.timer = "\(minute) : 0\(second)"
                } else {
                    self.timer = "\(minute) : \(second)"
                }
            }
            
            /// When the timer reaches 0, it will be stopped through the invalidate method.
            if timerCounter == 0 {
                self.brainstormTimer.invalidate()
                self.isTimerActive = false
            }
        })
        
    }
}

// MARK: - MultipeerConnectivity Session Delegate Functions
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
