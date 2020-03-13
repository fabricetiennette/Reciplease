//
//  AppCoordinator.swift
//  Reciplease
//
//  Created by Fabrice Etiennette on 11/03/2020.
//  Copyright © 2020 Fabrice Etiennette. All rights reserved.
//

import UIKit

class AppCoordinator {

    private unowned var appDelegate: AppDelegate
    private var mainTapBarCoordinator: MainCoordinator?
    private let context: Context
    private let stack: CoreDataStack

    init(appDelegate: AppDelegate, context: Context, stack: CoreDataStack) {
        self.appDelegate = appDelegate
        self.context = context
        self.stack = stack
    }

    func start() {
        appDelegate.window = UIWindow(frame: UIScreen.main.bounds)
        appDelegate.window!.rootViewController = UIViewController()
        appDelegate.window!.tintColor = .brown
        appDelegate.window!.makeKeyAndVisible()
        showMain()
    }

    func showMain() {
        mainTapBarCoordinator = MainCoordinator(window: appDelegate.window!, context: context, stack: stack)
        mainTapBarCoordinator?.start()
    }
}
