//
//  Model.swift
//  MomSpaCh
//
//  Created by 김동현 on 7/2/24.
//
//chickenHallf 오타수정?

import UIKit

struct Data {
  var totalPrice = 0
  var count = 0
  var totalCount = 0
  var foodImageView = UIImageView()
  
  let foodMenu = [
    "buger" : [UIImage(named: "buggerBeefSteak") : 10900,
               UIImage(named: "buggerBulgogi") : 10800,
               UIImage(named: "buggerChiliShrimp") : 11900,
               UIImage(named: "buggerDeepCheese") : 12900,
               UIImage(named: "buggerDeluxeBulgogi") : 13900,
               UIImage(named: "buggerFillet") : 9900,
               UIImage(named: "buggerGrilledBeef") : 11900,
               UIImage(named: "buggerInvredible") : 14900,
               UIImage(named: "buggerShrimp") : 10900,
               UIImage(named: "buggerShrimpBulgogi") : 14900,
               UIImage(named: "buggerSpicyThigh") : 10900,
               UIImage(named: "buggerThigh") : 10900],
    
    "chicken" : [UIImage(named: "chickenCheeseSprinkled"): 21900,
                 UIImage(named: "chickenChipao"): 20900,
                 UIImage(named: "chickenFried"): 18900,
                 UIImage(named: "chickenHallf"): 19900,
                 UIImage(named: "chickenSoyGalic"): 20900],
    
    "sideMenu" : [UIImage(named: "sideCheeseBall"): 4900,
                  UIImage(named: "sideCheeseStick"): 1900,
                  UIImage(named: "sideCorn"): 3900,
                  UIImage(named: "sideFrenchFries"): 2900,
                  UIImage(named: "sidePopcornBall"): 4900,
                  UIImage(named: "sideTwistSnack"): 5900],
    
    "drink" : [UIImage(named: "drinkAmericano"): 3500,
               UIImage(named: "drinkCider"): 2000,
               UIImage(named: "drinkCola"): 2000,
               UIImage(named: "drinkGreenGrapeAde"): 3500,
               UIImage(named: "drinkLemonAde"): 3500,
               UIImage(named: "drinkOrangeJuice"): 3500]
  ]
}
