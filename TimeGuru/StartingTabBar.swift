//
//  StartingTabBar.swift
//  TimeGuru
//
//  Created by Harlan Rich on 2022-03-31.
//

import UIKit

class StartingTabBar: UITabBarController {
    @IBInspectable var initIndex: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedIndex = initIndex
    }
}
