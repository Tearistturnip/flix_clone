//
//  Reachability.swift
//  flix_clone
//
//  Created by Justin Lee on 2/5/18.
//  Copyright © 2018 Justin Lee. All rights reserved.
//

import Foundation
import SystemConfiguration

let ReachabilityDidChangeNotificationName = "ReachabilityDidChangeNotification"

enum ReachabilityStatus {
    case notReachable
    case reachableViaWiFi
    case reachableViaWWAN
}

class Reachability: NSObject{
    private var networkReachability: SCNetworkReachability?
    
}
