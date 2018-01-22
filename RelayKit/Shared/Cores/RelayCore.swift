//
//  RelayCore.swift
//  RelayKit
//
//  Created by David Moeller on 16.09.17.
//  Copyright © 2017 David Moeller. All rights reserved.
//

import Foundation
import WatchConnectivity

public enum RelayCoreError: Error {
    case wrongMethodType
}

public protocol RelayCore: class {
    
    static var methodType: SendingMethod.Type { get }
    
    var didReceiveMessage: (_ message: [String: Any], _ method: SendingMethod, _ replyHandler: (([String: Any]) -> Void)?) -> Void { get set }
    
    func sendMessage(_ data: [String: Any], _ method: SendingMethod, replyHandler: @escaping ([String: Any]) -> Void, errorHandler: @escaping (Error) -> Void) throws
}

public class SimpleCore: RelayCore {
    
    public enum SimpleCoreMethod: SendingMethod {
        case sendMessage
    }
    
    static public let methodType: SendingMethod.Type = SimpleCoreMethod.self
    
    public var didReceiveMessage: ([String : Any], SendingMethod, (([String : Any]) -> Void)?) -> Void
    
    init() {
        self.didReceiveMessage = { _, _, _ in }
    }
    
    public func sendMessage(_ data: [String : Any], _ method: SendingMethod, replyHandler: @escaping ([String : Any]) -> Void, errorHandler: @escaping (Error) -> Void) throws {
        
        guard let method = method as? SimpleCoreMethod else { throw RelayCoreError.wrongMethodType }
        
        self.didReceiveMessage(data, method, replyHandler)
    }
    
}
