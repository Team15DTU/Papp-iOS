//
//  TabBarExtension.swift
//  Papp-iOS
//
//  Created by Nikolaj Wassmann on 14/04/2020.
//  Copyright © 2020 Nikolaj Wassmann. All rights reserved.
//

import UIKit


extension MapViewController {
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
           
           if item.tag == 1{
               
           }
           
           if item.tag == 2{
            
           }
           if item.tag == 3{
               present(rightMenuNavigationController, animated: true, completion: nil)
           }
       }
    
}
