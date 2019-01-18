//
//  Meal.swift
//  TestFoodVisor
//
//  Created by Nizar Elhraiech on 17/01/2019.
//  Copyright © 2019 Nizar Elhraiech. All rights reserved.
//

import Foundation
class Meal{
    var stater: Food
    var mealPrincipal: Food
    var desert: Food
    var totalCalorie : Int
    init(stater: Food, mealPrincipal: Food, desert: Food , totalCalorie : Int) {
        self.stater = stater
        self.mealPrincipal = mealPrincipal
        self.desert = desert
        self.totalCalorie = totalCalorie

    }

}
