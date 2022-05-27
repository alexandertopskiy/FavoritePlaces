//
//  Created by Alexander Loshakov on 20/05/2022
//  Copyright © 2022 Alexander Loshakov. All rights reserved.
//

import UIKit

typealias LaunchOptionsKey = [UIApplication.LaunchOptionsKey: Any]

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: LaunchOptionsKey?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        UINavigationBar.appearance().largeTitleTextAttributes = [
            .foregroundColor: UIColor.black
        ]
        let mainViewController = LocationsBuilder().setTitle("Landmarks").build()
        let navigationController = UINavigationController(rootViewController: mainViewController)
        navigationController.navigationBar.prefersLargeTitles = true
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        return true
    }
}
