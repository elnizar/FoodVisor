//
//  Food.swift
//  TestFoodVisor
//
//  Created by Nizar Elhraiech on 17/01/2019.
//  Copyright © 2019 Nizar Elhraiech. All rights reserved.
//

import Foundation
class Food {
    var display_name: String?
    var cal: Int?
    var type: String?
    var imgUrl: String?
    
    init(display_name: String, cal: Int, type: String, imgUrl: String) {
        self.display_name = display_name
        self.cal = cal
        self.type = type
        self.imgUrl = imgUrl
    }
    
}
