//
//  ViewController.swift
//  MomSpaCh
//
//  Created by 김동현 on 7/2/24.
//

import UIKit

import SnapKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate,
                      CustomTableViewCellDelegate, UICollectionViewDelegate,
                      MenuCollectionViewCellDelegate, UICollectionViewDataSource,
                      UICollectionViewDelegateFlowLayout, MainViewDelegate {
  
  var checkDuplication: Bool = false
  var menuData = MenuData()
  static let identifier = "mainViewController"
  private let countLabel = UILabel()
  private let nameLabel = UILabel()

  // MARK: - UIViewController (Developer: 조수환)
  
  var mainView: MainView!
  override func loadView() {
    super.loadView()
    mainView = MainView(frame: self.view.frame)
    self.view = mainView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupTableView()
    setupCollectionView()
  }
  
  // MARK: - UICollectionView (Developer: 김윤홍)
  /// 컬렉션뷰 만들기
  func setupCollectionView() {
    mainView.menuCollectionView.dataSource = self
    mainView.menuCollectionView.delegate = self
    mainView.menuCollectionView.register(
      MenuCollectionViewCell.self,
      forCellWithReuseIdentifier: MenuCollectionViewCell.identifier)
  }

  /// 컬렉션뷰 셀을 컬렉션 뷰 안에 넣기
  /// - Parameters:
  ///   - collectionView: 넣어야할 컬렉션뷰
  ///   - indexPath: cell indexPath
  /// - Returns: 다운캐스팅 실패시 기본셀 리턴
  func collectionView(
    _ collectionView: UICollectionView,
    cellForItemAt indexPath: IndexPath
  ) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: MenuCollectionViewCell.identifier,
      for: indexPath
    ) as? MenuCollectionViewCell else {
      return UICollectionViewCell()
    }

    switch mainView.selectedCategory {
    case "버거":
      let burgerItem = menuData.menuArray.filter { $0.category == "burger" }
      let item = burgerItem[indexPath.row]
      cell.configure(withImageName: item.imageName, price: item.menuPrice, name: item.menuName)

    case "치킨":
      let chickenItem = menuData.menuArray.filter { $0.category == "chicken" }
      let item = chickenItem[indexPath.row]
      cell.configure(withImageName: item.imageName, price: item.menuPrice, name: item.menuName)

    case "사이드":
      let sideMenuItem = menuData.menuArray.filter { $0.category == "sideMenu" }
      let item = sideMenuItem[indexPath.row]
      cell.configure(withImageName: item.imageName, price: item.menuPrice, name: item.menuName)

    case "음료":
      let drinkItem = menuData.menuArray.filter { $0.category == "drink" }
      let item = drinkItem[indexPath.row]
      cell.configure(withImageName: item.imageName, price: item.menuPrice, name: item.menuName)

    default:
      let item = menuData.menuArray[indexPath.row]
      cell.configure(withImageName: item.imageName, price: item.menuPrice, name: item.menuName)
    }
    cell.delegate = self
    return cell
  }

  /// 컬렉션 뷰 내부 셀구성 개수 설정
  /// - Returns: 개수
  func collectionView(
    _ collectionView: UICollectionView,
    numberOfItemsInSection section: Int
  ) -> Int {
    switch mainView.selectedCategory {
    case "버거":
      return menuData.menuArray.filter { $0.category == "burger" }.count
    case "치킨":
      return menuData.menuArray.filter { $0.category == "chicken" }.count
    case "사이드":
      return menuData.menuArray.filter { $0.category == "sideMenu" }.count
    case "음료":
      return menuData.menuArray.filter { $0.category == "drink" }.count
    default:
      return menuData.menuArray.count
    }
  }
  
  /// collectionView 제약 조건
  /// - Returns: 사이즈
  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    sizeForItemAt indexPath: IndexPath
  ) -> CGSize {
    return CGSize(width: 130, height: 170)
  }

  // MARK: - UITableView (Developer: 백시훈)

  /// addOrderList
  /// - Parameters: 메뉴에서 버튼을 눌러 주문리스트에 추가하는 함수
  ///   - pay: 금액
  ///   - name: 상품
  func addOrderList(_ pay: String, _ name: String) {
    if menuData.nameData.contains(name) {
      checkDuplication = true
      for i in 0..<menuData.nameData.count {
        if menuData.nameData[i] == name{
          menuData.countData[i] += 1
          menuData.priceData[i] += Int(pay)!
        }
      }
      mainView.allCount.text = String(menuData.countData.reduce(0, +))
    } else {
      checkDuplication = false
      menuData.nameData.append(name)
      menuData.priceData.append(Int(pay)!)
      menuData.countData.append(1)
    }
    mainView.allCount.text = String(menuData.countData.reduce(0, +))
    mainView.payLabel.text = String(menuData.priceData.reduce(0, +))
    mainView.tableView.reloadData()
  }

  /// setupTableView: 테이블 뷰 생성
  func setupTableView() {
    mainView.tableView.dataSource = self
    mainView.tableView.delegate = self
    mainView.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    mainView.tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "CustomCell") // 셀 등록
  }

  /// tableView: 테이블 뷰의 cell을 갯수를 리턴하는 메서드
  /// - Parameters:
  ///   - tableView: 테이블 뷰
  ///   - section: 갯수
  /// - Returns: 테이블 cell 갯수
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return menuData.nameData.count
  }

  /// tableView: 테이블 뷰 구성요소 데이터 넣는 메서드
  /// - Parameters:
  ///   - tableView: 테이블 뷰
  ///   - indexPath: 선택된 cell
  /// - Returns: cell
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(
      withIdentifier: "CustomCell",
      for: indexPath
    ) as? CustomTableViewCell else {
      return UITableViewCell()
    }
    cell.itemNameLabel.text = menuData.nameData[indexPath.row]
    cell.countLabel.text = String(menuData.countData[indexPath.row])
    cell.plusButton.tag = indexPath.row
    cell.minusButton.tag = indexPath.row
    cell.payLabel.text = String(menuData.priceData[indexPath.row])
    cell.delegate = self
    return cell
  }

  /// deleteButton: cell에서 삭제된 데이터 처리
  /// - Parameter cell: 삭제 cell
  func deleteButton(in cell: CustomTableViewCell) {
    if let indexPath = mainView.tableView.indexPath(for: cell) {
      menuData.nameData.remove(at: indexPath.row)
      menuData.priceData.remove(at: indexPath.row)
      menuData.countData.remove(at: indexPath.row)
      mainView.tableView.deleteRows(at: [indexPath], with: .automatic)
      mainView.allCount.text = String(menuData.countData.reduce(0, +))
      mainView.payLabel.text = String(menuData.priceData.reduce(0, +))
    }
  }

  /// plusButtonTap: 플러스 버튼시 이벤트
  /// - Parameter cell: 플러스 버튼 누른 cell
  func plusButtonTap(in cell: CustomTableViewCell) {
    guard let indexPath = mainView.tableView.indexPath(for: cell) else {
      return
    }

    if let cell = mainView.tableView.cellForRow(
      at: indexPath
    ) as? CustomTableViewCell, let countText = cell.itemNameLabel.text {
      for i in 0..<menuData.nameData.count {
        if menuData.nameData[i] == countText {
          let count = Int(menuData.countData[i])
          menuData.countData[i] += 1
          menuData.countSum = menuData.countData.reduce(0, +)
          menuData.priceData[i] = (menuData.priceData[i] / count) * (count + 1)
          menuData.paySum = menuData.priceData.reduce(0, +)
        }
      }
    }
    mainView.allCount.text = String(menuData.countSum)
    mainView.payLabel.text = String(menuData.paySum)
  }

  /// minusButtonTap : 마이너스 버튼 클릭 이벤트 메서드
  /// - Parameter cell: 마이너스 버튼 누른 cell
  func minusButtonTap(in cell: CustomTableViewCell) {
    guard let indexPath = mainView.tableView.indexPath(for: cell) else {
      return
    }
    if let cell = mainView.tableView.cellForRow(at: indexPath) as? CustomTableViewCell,
       let countText = cell.itemNameLabel.text {

      for i in 0..<menuData.nameData.count {
        if menuData.nameData[i] == countText {
          let count = Int(menuData.countData[i])
          menuData.countData[i] -= 1
          menuData.countSum = menuData.countData.reduce(0, +)
          menuData.priceData[i] = (menuData.priceData[i] / count) * (count - 1)
          menuData.paySum = menuData.priceData.reduce(0, +)
        }
      }
      mainView.allCount.text = String(menuData.countSum)
      mainView.payLabel.text = String(menuData.paySum)
    }
  }

  /// 주문 내역을 처음 상태로 초기화
  func orderListClear() {
    menuData.nameData = []
    menuData.priceData = []
    menuData.countData = []
    mainView.allCount.text = "0"
    mainView.payLabel.text = "0"
    mainView.tableView.reloadData()
  }
  
  func clickedOrderButton() {
    if menuData.nameData.isEmpty {
      let emptyAlert = UIAlertController(
        title: "주문내역을 확인해 주십시오",
        message: "",
        preferredStyle: .alert
      )
      let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
      emptyAlert.addAction(okAction)
      present(emptyAlert, animated: true, completion: nil)
    } else {
      let alert = UIAlertController(
        title: "최종 결제 금액 \(mainView.payLabel.text!)원입니다. 주문하시겠습니까?",
        message: "",
        preferredStyle: .alert
      )
      let yesAction = UIAlertAction(title: "네", style: .default) { _ in
        self.orderCompletedAlert()
      }
      let noAction = UIAlertAction(title: "아니오", style: .cancel, handler: nil)
      alert.addAction(yesAction)
      alert.addAction(noAction)
      present(alert, animated: true, completion: nil)
    }
  }

  /// 최종 주문 완료 메세지
  private func orderCompletedAlert() {
    let completedAlert = UIAlertController(
      title: "주문 완료되었습니다.",
      message: "",
      preferredStyle: .alert
    )
    let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
    completedAlert.addAction(okAction)
    orderListClear()
    present(completedAlert, animated: true, completion: nil)
  }
}
