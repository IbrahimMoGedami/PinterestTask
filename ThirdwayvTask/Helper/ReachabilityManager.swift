//
//  ReachabilityManager.swift
//  ThirdwayvTask
//
//  Created by Ibrahim Mo Gedami on 26/02/2022.
//

import Foundation
import Alamofire

// MARK: NetworkReachability

final class NetworkReachability {
    
    static let shared = NetworkReachability()

    private let reachability = NetworkReachabilityManager(host: "https://mocki.io/v1/66582140-ff28-4ab4-a9f7-adaa2e494417")!

    typealias NetworkReachabilityStatus = NetworkReachabilityManager.NetworkReachabilityStatus

    private init() {}
    
    /// Start observing reachability changes
    func startListening() {
        reachability.startListening { [weak self] status in
            switch status {
            case .notReachable:
                self?.updateReachabilityStatus(.notReachable)
            case .reachable(let connection):
                self?.updateReachabilityStatus(.reachable(connection))
            case .unknown:
                break
            }
        }
    }
    
    /// Stop observing reachability changes
    func stopListening() {
        reachability.stopListening()
    }
    
    
    /// Updated ReachabilityStatus status based on connectivity status
    ///
    /// - Parameter status: `NetworkReachabilityStatus` enum containing reachability status
    private func updateReachabilityStatus(_ status: NetworkReachabilityStatus) {
        switch status {
        case .notReachable:
            print("Internet not available")
        case .reachable(.ethernetOrWiFi), .reachable(.cellular):
            print("Internet available")
        case .unknown:
            break
        }
    }

    /// returns current reachability status
    var isReachable: Bool {
        return reachability.isReachable
    }

    /// returns if connected via cellular
    var isConnectedViaCellular: Bool {
        return reachability.isReachableOnCellular
    }

    /// returns if connected via cellular
    var isConnectedViaWiFi: Bool {
        return reachability.isReachableOnEthernetOrWiFi
    }

    deinit {
        stopListening()
    }
}
