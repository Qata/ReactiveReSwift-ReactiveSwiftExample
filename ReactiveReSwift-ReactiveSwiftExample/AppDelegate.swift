//
//  AppDelegate.swift
//  ReactiveReSwift-ReactiveSwiftExample
//
//  Created by Charlotte Tortorella on 2/12/16.
//  Copyright © 2016 ReSwift. All rights reserved.
//

import UIKit
import ReactiveReSwift
import ReactiveSwift

let middleware = Middleware<AppState> { _, _, action in
    print("Received action:")
    return action
}.map { _, _, action in
    print(action)
    return action
}

// The global application store, which is responsible for managing the appliction state.
let mainStore = Store(
    reducer: counterReducer,
    stateType: AppState.self,
    observable: MutableProperty(AppState()),
    middleware: middleware
)

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
}

