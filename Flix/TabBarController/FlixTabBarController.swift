//
//  FlixTabBarController.swift
//  Flix
//
//  Created by Pann Cherry on 4/6/22.
//  Copyright © 2022 Pann Cherry. All rights reserved.
//

import UIKit

enum TabBarItems: Int {
    case nowPlaying = 1
    case posters = 2
}

class FlixTabBarController: UITabBarController, UITabBarControllerDelegate {

    let titleArray = ["Now Playing", "Posters"]
    let unSelectedImageArray = ["now_playing_tabbar_item", "superhero_tabbar_item"]
    let selectedImageArray = ["now_playing_tabbar_item", "superhero_tabbar_item"]

    override func viewDidLoad() {
        super.viewDidLoad()

        self.delegate = self
        self.viewControllers = [
            UINavigationController(rootViewController: NowPlayingMoviesViewController()),
            UINavigationController(rootViewController: PopularMoviesViewController())
        ]

        self.setUpTabbarAppearance()
    }

    func setUpTabbarAppearance() {
        if let count = self.tabBar.items?.count {
            for i in 0...(count-1) {
                let imageNameForSelectedState   = self.selectedImageArray[i]
                let imageNameForUnselectedState = self.unSelectedImageArray[i]

                self.tabBar.items?[i].selectedImage = UIImage(named: imageNameForSelectedState)?.withRenderingMode(.alwaysOriginal)
                self.tabBar.items?[i].image = UIImage(named: imageNameForUnselectedState)?.withRenderingMode(.automatic)
                self.tabBar.items?[i].title = self.titleArray[i]
            }
        }
    }

}
