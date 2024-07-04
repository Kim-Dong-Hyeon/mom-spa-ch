//
//  Model.swift
//  MomSpaCh
//
//  Created by 김동현 on 7/2/24.
//

struct Data {
  var totalPrice = 0
  var count = 0
  var totalCount = 0
  
  let burger : [String] = ["burgerBeefSteak", "burgerBulgogi", "burgerChiliShrimp", "burgerDeepCheese",
                 "burgerDeluxeBulgogi", "burgerFillet", "burgerGrilledBeef", "burgerInvredible",
                 "burgerShrimp", "burgerShrimpBulgogi", "burgerSpicyThigh", "burgerThigh"]
  
  let chicken = ["chickenCheeseSprinkled", "chickenChipao", "chickenFried", "chickenHalf", "chickenSoyGalic"]

  let sideMenu = ["sideCheeseBall", "sideCheeseStick", "sideCorn", "sideFrenchFries", "sidePopcornBall", "sideTwistSnack"]
  
  let drink = ["drinkAmericano", "drinkCider", "drinkCola", "drinkGreenGrapeAde", "drinkLemonAde", "drinkOrangeJuice"]
  
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
  
  let burgerPrice = [12900, 11900, 13900, 12900, 11900, 9900, 11800, 11900, 13900, 12900, 9900, 8900]
  let chickenPrice = [18900, 21900, 23900, 22900, 21900]
  let sidePrice = [3900, 4900, 3900, 2900, 3900, 4900]
  let drinkPrice = [2900, 1900, 1900, 2900, 2900, 3900]
}
