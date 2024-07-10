//
//  Model.swift
//  MomSpaCh
//
//  Created by 김동현 on 7/2/24.
//

struct MenuItem {
  let category: String
  let imageName: String
  let menuName: String
  let menuPrice: Int
}

enum categoryMapping: String {
  case all
  case burger
  case chicken
  case sideMenu
  case drink
}

struct MenuData {
  var nameData = [String]()
  var priceData = [Int]()
  var countData = [Int]()
  var countSum = 0
  var paySum = 0
  let category = categoryMapping.RawValue()

  let menuArray = [
    MenuItem(
      category: categoryMapping.burger.rawValue,
      imageName: "burgerBeefSteak",
      menuName: "비프스테이크버거",
      menuPrice: 8900
    ),
    MenuItem(
      category: categoryMapping.burger.rawValue,
      imageName: "burgerBulgogi",
      menuName: "불고기버거",
      menuPrice: 6900
    ),
    MenuItem(
      category: categoryMapping.burger.rawValue,
      imageName: "burgerChiliShrimp",
      menuName: "칠리새우버거",
      menuPrice: 8900
    ),
    MenuItem(
      category: categoryMapping.burger.rawValue,
      imageName: "burgerDeepCheese",
      menuName: "딥치즈버거",
      menuPrice: 7900
    ),
    MenuItem(
      category: categoryMapping.burger.rawValue,
      imageName: "burgerDeluxeBulgogi",
      menuName: "디럭스불고기버거",
      menuPrice: 8900
    ),
    MenuItem(
      category: categoryMapping.burger.rawValue,
      imageName: "burgerFillet",
      menuName: "휠렛버거",
      menuPrice: 6900
    ),
    MenuItem(
      category: categoryMapping.burger.rawValue,
      imageName: "burgerGrilledBeef",
      menuName: "그릴드비프버거",
      menuPrice: 7900
    ),
    MenuItem(
      category: categoryMapping.burger.rawValue,
      imageName: "burgerInvredible",
      menuName: "언블리버블버거",
      menuPrice: 8900
    ),
    MenuItem(
      category: categoryMapping.burger.rawValue,
      imageName: "burgerShrimp",
      menuName: "통새우버거",
      menuPrice: 9900
    ),
    MenuItem(
      category: categoryMapping.burger.rawValue,
      imageName: "burgerShrimpBulgogi",
      menuName: "새우불고기버거",
      menuPrice: 9900
    ),
    MenuItem(
      category: categoryMapping.burger.rawValue,
      imageName: "burgerSpicyThigh",
      menuName: "불싸이버거",
      menuPrice: 8900
    ),
    MenuItem(
      category: categoryMapping.burger.rawValue,
      imageName: "burgerThigh",
      menuName: "싸이버거",
      menuPrice: 3900
    ),
    MenuItem(
      category: categoryMapping.chicken.rawValue,
      imageName: "chickenCheeseSprinkled",
      menuName: "치즈뿌치",
      menuPrice: 22900
    ),
    MenuItem(
      category: categoryMapping.chicken.rawValue,
      imageName: "chickenChipao",
      menuName: "치파오싸이치킨",
      menuPrice: 21900
    ),
    MenuItem(
      category: categoryMapping.chicken.rawValue,
      imageName: "chickenFried",
      menuName: "후라이드치킨",
      menuPrice: 18900
    ),
    MenuItem(
      category: categoryMapping.chicken.rawValue,
      imageName: "chickenHalf",
      menuName: "반반치킨",
      menuPrice: 19900
    ),
    MenuItem(
      category: categoryMapping.chicken.rawValue,
      imageName: "chickenSoyGalic",
      menuName: "간장마늘치킨",
      menuPrice: 19900
    ),
    MenuItem(
      category: categoryMapping.sideMenu.rawValue,
      imageName: "sideCheeseBall",
      menuName: "치즈볼",
      menuPrice: 4900
    ),
    MenuItem(
      category: categoryMapping.sideMenu.rawValue,
      imageName: "sideCheeseStick",
      menuName: "치즈스틱",
      menuPrice: 2900
    ),
    MenuItem(
      category: categoryMapping.sideMenu.rawValue,
      imageName: "sideCorn",
      menuName: "콘샐러드",
      menuPrice: 2900
    ),
    MenuItem(
      category: categoryMapping.sideMenu.rawValue,
      imageName: "sideFrenchFries",
      menuName: "케이준양념감자",
      menuPrice: 3900
    ),
    MenuItem(
      category: categoryMapping.sideMenu.rawValue,
      imageName: "sidePopcornBall",
      menuName: "팝콘볼",
      menuPrice: 4900
    ),
    MenuItem(
      category: categoryMapping.sideMenu.rawValue,
      imageName: "sideTwistSnack",
      menuName: "꿀꽈배기크림치즈",
      menuPrice: 3900
    ),
    MenuItem(
      category: categoryMapping.drink.rawValue,
      imageName: "drinkAmericano",
      menuName: "아이스아메리카노",
      menuPrice: 2900
    ),
    MenuItem(
      category: categoryMapping.drink.rawValue,
      imageName: "drinkCider",
      menuName: "사이다",
      menuPrice: 1900
    ),
    MenuItem(
      category: categoryMapping.drink.rawValue,
      imageName: "drinkCola",
      menuName: "콜라",
      menuPrice: 1900
    ),
    MenuItem(
      category: categoryMapping.drink.rawValue,
      imageName: "drinkGreenGrapeAde",
      menuName: "청포도에이드",
      menuPrice: 3900
    ),
    MenuItem(
      category: categoryMapping.drink.rawValue,
      imageName: "drinkLemonAde",
      menuName: "레몬에이드",
      menuPrice: 3900
    ),
    MenuItem(
      category: categoryMapping.drink.rawValue,
      imageName: "drinkOrangeJuice",
      menuName: "오렌지주스",
      menuPrice: 3900
    )
  ]
}
