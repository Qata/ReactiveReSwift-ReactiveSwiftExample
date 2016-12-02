//
//  ReactiveReSwiftBridge.swift
//  ReactiveReSwift-ReactiveSwiftExample
//
//  Created by Charlotte Tortorella on 2/12/16.
//  Copyright © 2016 ReSwift. All rights reserved.
//

import ReactiveReSwift
import ReactiveSwift

extension MutableProperty: ObservablePropertyType {
    public typealias ValueType = Value
    public typealias DisposableType = AnyDisposable
    
    @discardableResult
    public func subscribe(_ function: @escaping (Value) -> Void) -> AnyDisposable? {
        let disposable = self.producer.on(value: function).start()
        return AnyDisposable(disposable)
    }
}

extension Signal: StreamType {
    public typealias ValueType = Value
    public typealias DisposableType = AnyDisposable
    
    @discardableResult
    public func subscribe(_ function: @escaping (Value) -> Void) -> AnyDisposable? {
        let disposable = self.observe { event in
            if case let .value(value) = event {
                function(value)
            }
        }
        return disposable.map { AnyDisposable($0) }
    }
}

extension SignalProducer: StreamType {
    public typealias ValueType = Value
    public typealias DisposableType = AnyDisposable
    
    @discardableResult
    public func subscribe(_ function: @escaping (Value) -> Void) -> AnyDisposable? {
        return AnyDisposable(self.on(value: function).start())
    }
}

extension AnyDisposable: SubscriptionReferenceType {}
