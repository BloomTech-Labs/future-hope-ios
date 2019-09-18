//
//  ConcurrentOperation.swift
//  Future-Hope
//
//  Created by HSV on 9/17/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

import Foundation

class ConcurrentOperation: Operation {
    private let stateQueue = DispatchQueue(label: "com.LambdaSchool.Future-Hope.ConcurrentOperationStateQueue")
    
    private var _state = State.isReady

    enum State: String {
        case isReady, isExecuting, isFinished
    }
    
    // MARK: NSOperation
    
    override dynamic var isReady: Bool {
        return super.isReady && state == .isReady
    }
    
    override dynamic var isExecuting: Bool {
        return state == .isExecuting
    }
    
    override dynamic var isFinished: Bool {
        return state == .isFinished
    }
    
    override var isAsynchronous: Bool {
        return true
    }
    
    var state: State {
        get {
            var result: State?
            let queue = self.stateQueue
            queue.sync {
                result = _state
            }
            return result!
        }
        
        set {
            let oldValue = state
            willChangeValue(forKey: newValue.rawValue)
            willChangeValue(forKey: oldValue.rawValue)
            
            stateQueue.sync { self._state = newValue }
            
            didChangeValue(forKey: oldValue.rawValue)
            didChangeValue(forKey: newValue.rawValue)
        }
    }
    
    
    
}
