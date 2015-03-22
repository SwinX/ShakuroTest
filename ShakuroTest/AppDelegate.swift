//
//  AppDelegate.swift
//  ShakuroTest
//
//  Created by Ilia Isupov on 21.03.15.
//  Copyright (c) 2015 Ilia Isupov. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.Black); //progress hud setup
        return true
    }

}

