//
//  Model.swift
//  MomSpaCh
//
//  Created by 김동현 on 7/2/24.
//

import UIKit

struct Data {
  var totalPrice = 0
  var count = 0
  var totalCount = 0
  var foodImageView = UIImageView()
  
  let foodMenu = [
    "burger" : [UIImage(named: "burgerBeefSteak") : 10900,
                UIImage(named: "burgerBulgogi") : 10800,
                UIImage(named: "burgerChiliShrimp") : 11900,
                UIImage(named: "burgerDeepCheese") : 12900,
                UIImage(named: "burgerDeluxeBulgogi") : 13900,
                UIImage(named: "burgerFillet") : 9900,
                UIImage(named: "burgerGrilledBeef") : 11900,
                UIImage(named: "burgerInvredible") : 14900,
                UIImage(named: "burgerShrimp") : 10900,
                UIImage(named: "burgerShrimpBulgogi") : 14900,
                UIImage(named: "burgerSpicyThigh") : 10900,
                UIImage(named: "burgerThigh") : 10900],
    
    "chicken" : [UIImage(named: "chickenCheeseSprinkled"): 21900,
                 UIImage(named: "chickenChipao"): 20900,
                 UIImage(named: "chickenFried"): 18900,
                 UIImage(named: "chickenHalf"): 19900,
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
  
  let koreanName = [
    "burgerBeefSteak" : "비프스테이크버거",
    "burgerBulgogi" : "불고기버거",
    "burgerChiliShrimp" : "칠리새우버거",
    "burgerDeepCheese" : "딥치즈버거",
    "burgerDeluxeBulgogi" : "디럭스불고기버거",
    "burgerFillet" : "휠렛버거",
    "burgerGrilledBeef" : "그릴드비프버거",
    "burgerInvredible" : "언블리버블버거",
    "burgerShrimp" : "통새우버거",
    "burgerShrimpBulgogi" : "새우불고기버거",
    "burgerSpicyThigh" : "불싸이버거",
    "burgerThigh" : "싸이버거",
    "chickenCheeseSprinkled" : "치즈뿌린치킨",
    "chickenChipao" : "치파오싸이치킨",
    "chickenFried" : "후라이드치킨",
    "chickenHalf" : "반반치킨",
    "chickenSoyGalic" : "간장마늘치킨",
    "sideCheeseBall" : "치즈볼",
    "sideCheeseStick" : "치즈스틱",
    "sideCorn" : "콘샐러드",
    "sideFrenchFries" : "케이준양념감자",
    "sidePopcornBall" : "팝콘볼",
    "sideTwistSnack" : "꿀꽈배기크림치즈",
    "drinkAmericano" : "아이스아메리카노",
    "drinkCider" : "사이다",
    "drinkCola" : "콜라",
    "drinkGreenGrapeAde" : "청포도에이드",
    "drinkLemonAde" : "레몬에이드",
    "drinkOrangeJuice" : "오렌지주스"]
}
