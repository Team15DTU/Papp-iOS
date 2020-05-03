//
//  TabBarExtension.swift
//  Papp-iOS
//
//  Created by Nikolaj Wassmann on 14/04/2020.
//  Copyright © 2020 Nikolaj Wassmann. All rights reserved.
//

import UIKit


extension MapViewController {
    
    //MARK: Delegate methods
    
   func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
           
    if previousSelectedTabBarItem == 1 && item.tag != 3 {
            exitTip()
        }
        else if previousSelectedTabBarItem == 2 && item.tag != 3{
            exitPVagt()
        }
           
        switch item.tag {
        case 0:
            previousSelectedTabBarItem = 0
            break
        
        case 1:
            enterTip()
            previousSelectedTabBarItem = 1
            break
            
        case 2:
            enterPVagt()
            previousSelectedTabBarItem = 2
            break
               
        case 3:
            present(rightMenuNavigationController, animated: true, completion: nil)
            previousSelectedTabBarItem = 3
            break
        default:
            print("WARNING: No such item found at \(item.tag)")
        }
       
    }
    
}
