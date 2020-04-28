//
//  TabBarExtension.swift
//  Papp-iOS
//
//  Created by Nikolaj Wassmann on 14/04/2020.
//  Copyright © 2020 Nikolaj Wassmann. All rights reserved.
//

import UIKit
import SideMenu


extension MapViewController {
    
    //MARK: Delegate methods
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
        if GlobalVariables.previousItem == 1 && item.tag != 3 {
            exitTip()
        }
        else if GlobalVariables.previousItem == 2 && item.tag != 3{
            exitPVagt()
        }
        
        switch item.tag {
        case 0:
            GlobalVariables.previousItem = 0
            enableTipMapTap()
            break
            
        case 1:
            disableTipMapTap()
            enterTip()
            
            GlobalVariables.previousItem = 1
            break
            
        case 2:
            disableTipMapTap()
            enterPVagt()
            
            GlobalVariables.previousItem = 2
            break
            
        case 3:
            GlobalVariables.tabBar = mapTabBar
            GlobalVariables.items = tabBarItems
            present(rightMenuNavigationController, animated: true, completion: nil)
            //GlobalVariables.previousItem = 3
            break
        default:
            print("WARNING: No such item found at \(item.tag)")
        }
        
    }
    
}
