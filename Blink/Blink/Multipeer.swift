//
//  Multipeer.swift
//  Blink
//
//  Created by Edgar Sgroi on 08/07/20.
//  Copyright © 2020 Artur Carneiro. All rights reserved.
//

import Foundation
import MultipeerConnectivity
import Combine

enum ConnectionStatus {
    case connected
    case connecting
    case notConnected
    case unknown
}

class Multipeer: NSObject, ObservableObject {
    
    static let shared = Multipeer()
    
    var peerID: MCPeerID
    var mcSession: MCSession
    var mcAdvertiserAssistant: MCAdvertiserAssistant
    
    var connectionStatus: ConnectionStatus
    var delegate: MCSessionDelegate?
//    @Published var connectedPeersName

    override init() {
        peerID = MCPeerID(displayName: UIDevice.current.name)
        mcSession = MCSession(peer: peerID, securityIdentity: nil, encryptionPreference: .required)
        connectionStatus = .notConnected
        mcAdvertiserAssistant = MCAdvertiserAssistant(serviceType: "blnk", discoveryInfo: nil, session: mcSession)
//        connectedPeersName = mcSession.peersName
        super.init()
//        Publishers.PeersListSubscription(request: URLRequest(url: URL(string: "teste")), subscriber: conn)
//        let _ = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer  in
//            self.connectedPeersName = self.mcSession.peersName
//        }
    }
}

extension MCSession {
    var peersName: [String] {
        connectedPeers.map({$0.displayName})
    }
}

extension Publishers {
    
    class PeersListSubscription<S: Subscriber>: Subscription where S.Input == Data, S.Failure == Error {
        private let session = URLSession.shared
        private let request: URLRequest
        private var subscriber: S?
        
        init(request: URLRequest, subscriber: S) {
            self.request = request
            self.subscriber = subscriber
            sendRequest()
        }
        
        func request(_ demand: Subscribers.Demand) {
            //TODO: - Optionaly Adjust The Demand
        }
        
        func cancel() {
            subscriber = nil
        }
        
        private func sendRequest() {
            guard let subscriber = subscriber else { return }
            session.dataTask(with: request) { (data, _, error) in
                _ = data.map(subscriber.receive)
                _ = error.map { subscriber.receive(completion: Subscribers.Completion.failure($0)) }
            }.resume()
        }
    }
    
    struct PeersListPublisher: Publisher {
        typealias Output = Data
        typealias Failure = Error
        
        private let urlRequest: URLRequest
        
        init(urlRequest: URLRequest) {
            self.urlRequest = urlRequest
        }
        
        func receive<S: Subscriber>(subscriber: S) where
            PeersListPublisher.Failure == S.Failure, PeersListPublisher.Output == S.Input {
                let subscription = PeersListSubscription(request: urlRequest,
                                                    subscriber: subscriber)
                subscriber.receive(subscription: subscription)
        }
    }
}

extension URLSession {
    func dataResponse(for request: URLRequest) -> Publishers.PeersListPublisher {
        return Publishers.PeersListPublisher(urlRequest: request)
    }
}
